require_relative 'env'

# TODO: refactor this file, please :D

def query(params:)
  params = Rack::Utils.build_query params
  url = "#{API_HOST}#{API_PATH}?#{params}"
  Get.g url
end

def price_to_i(price)
  price[1..-1].sub(/,/, '').to_i
end

# monkeypatch hash
class Hash
  alias :f :fetch
end

def match_spec(spec)
  spec =~ /lane|toyota safety sense|steering control|pre crash safety systems/i
end

def match_spec2(spec)
  spec =~ /adaptive cruise control|smart adaptive speed control/i
end

CARS_FOUND = []

def car_link_match(li:)
  match = li.match /\/classified\/advert\/(\d+)\?/
  match[1] if match
end

def car_links_match(links:)
  links.map do |li|
    car_link_match li: li
  end.compact
end

Slowkogiri = -> (html) { Nokogiri::HTML html } # slow to compile at least (c exts)

def query_page(page: 1)
  params  = default_params
  params[:page] = page
  body = query params: params
  puts body.f("refinements").f("count")
  html = body.f "html"
  page = Slowkogiri.(html)
  links = page.search "a"
  links = links.select { |li| li["href"] =~ /\/classified\/advert\/20/ }
  car_links = links.map { |li| li["href"] }
  car_ids = car_links_match links: car_links
  car_ids.uniq
end

def main
  car_ids = []
  params = {}
  1.upto(50) do |idx|
    begin
      car_ids += query_page page: idx
    rescue JSON::ParserError
      break
    end
    puts "PAGE: #{idx}"
  end
  car_ids.uniq!

  # headings = page.search "h3.atc-card__heading"
  car_ids.each do |car_id|
    url = "#{API_HOST}#{API_PATH_INIT}/#{car_id}"
    puts "REQ: #{url}"
    resp = Get.g url
    unless resp["advert"]
      puts "NO ADVERT (For PRICE)"
      next
    end
    price = resp.f("advert").f("price")
    vehicle = resp.f("vehicle")
    unless vehicle["derivativeId"]
      puts "NO DERIV ID"
      next
    end
    deriv_id = vehicle.f("derivativeId")
    year = vehicle.f("year")
    miles = vehicle["keyFacts"]["mileage"]
    year_manuf = vehicle.f("keyFacts").f("manufactured-year")
    car = {
      car: car_id,
      price: price,
      year: year,
      deriv_id: deriv_id,
      year_manuf: year_manuf,
      miles: miles,
    }
    puts "CAR: #{car_id} - Price: #{price} - Year: #{year} - deriv_id: #{deriv_id} - year-manuf: #{year_manuf} - miles: #{miles} "

    url = "#{API_HOST}#{API_PATH_DERIV}#{deriv_id}"
    puts "REQ: #{url}"
    resp = Get.g url
    specs = resp.f("techSpecs")

    haz_autopilot_safety = specs.find{ |spec| spec["specName"] == "Safety" }.f("specs").find{ |spec| match_spec spec }
    haz_autopilot_driver_conv = specs.find{ |spec| spec["specName"] == "Driver Convenience" }.f("specs").find{ |spec| match_spec spec }

    haz_acc_safety = specs.find{ |spec| spec["specName"] == "Safety" }.f("specs").find{ |spec| match_spec2 spec }
    haz_acc_driver_conv = specs.find{ |spec| spec["specName"] == "Driver Convenience" }.f("specs").find{ |spec| match_spec2 spec }

    haz_autopilot =
      (haz_autopilot_safety || haz_autopilot_driver_conv) &&
        (haz_acc_safety || haz_acc_driver_conv)

    # if default_params.fetch(:model) == "C-HR"
    #   haz_autopilot = haz_autopilot_safety || haz_autopilot_driver_conv
    # end

    puts "AUTOPILOT? > #{!!haz_autopilot} <"
    if haz_autopilot
      CARS_FOUND << car
    end
    puts "\n\n"
  end
  
  SearchLimitCarPrice = -> (car) {
    price = price_to_i car.f(:price)
    price < MAX_PRICE
  }

  puts "CARS FOUND (sorted):"
  require 'yaml'
  puts CARS_FOUND.sort_by{ |car| # TODO: do the same refactoring to .select() ( SearchLimitCarPrice ), extract in a function each one so at the end you will be able to do: `sort_by(&f1).select(&f2).map(&f3)`
    price_to_i car.f(:price)
  }.select(&SearchLimitCarPrice).map{ |car|
    new_car = car
    new_car[:link] = "https://www.autotrader.co.uk/classified/advert/#{car[:car]}"
    new_car
  }.compact.to_yaml
end

main
