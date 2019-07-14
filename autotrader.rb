require_relative 'env'

def query(params:)
  params = Rack::Utils.build_query params
  url = "#{API_HOST}#{API_PATH}?#{params}"
  Get.g url
end

def default_params
  {

    # make: "HONDA",
    # model: "CIVIC",
    # model: "CR-V",


    make: "TOYOTA",
    # model: "C-HR",
    # model: "COROLLA",

    "year-from": 2016,
    "year-to": 2018,
    # "year-from": 2018,
    # "year-from": 2018,

    radius: 1500,
    postcode: "e143uf",
    onesearchad: "Used",
    transmission: "Automatic",
    "writeoff-categories": "on",
    "body-type": "SUV",
    # "fuel-type": "Hybrid%20–%20Petrol%2FElectric",
  }
end

# LKAS = "Lane Keeping Assist"
# LKAS = "Lane Keep Assist System"

# monkeypatch hash
class Hash
  alias :f :fetch
end

# def match_spec(spec)
#   spec == LKAS
# end

def match_spec(spec)
  spec =~ /lane/i
  # spec =~ /lane|safety sense/i
  # Electronic Power Steering
end

CARS_FOUND = []

def query_page(page: 1)
  params  = default_params
  params[:page] = page
  body = query params: params
  puts body.f("refinements").f("count")
  html = body.f "html"
  page = Nokogiri::HTML html
  links = page.search "a"
  links = links.select { |li| li["href"] =~ /\/classified\/advert\/20/ }
  car_links = links.map { |li| li["href"] }
  car_ids = car_links.map do |li|
    match = li.match /\/classified\/advert\/(\d+)\?/
    match[1] if match
  end.compact
  car_ids.uniq!
  next_page = true
  car_ids
end

def main
  car_ids = []
  1.upto(20) do |idx|
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
    price = resp.f("advert").f("price")
    vehicle = resp.f("vehicle")
    unless vehicle["derivativeId"]
      puts "NO DERIV ID"
      next
    end
    deriv_id = vehicle.f("derivativeId")
    year = vehicle.f("year")
    miles = vehicle.f("keyFacts").f("mileage")
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
    haz_autopilot = resp.f("techSpecs").find{ |spec| spec["specName"] == "Safety" }.f("specs").find{ |spec| match_spec spec }
    puts "AUTOPILOT? > #{!!haz_autopilot} <"
    if haz_autopilot
      CARS_FOUND << car
    end
    puts "\n\n"
  end

  # /json/fpa/initial/201906219261925
  #
  # 0fe1c813d6434299aba501bbc63c1b9c

  # puts "Results:"
  # # puts results.to_yaml
  # results = results.f "listings"
  # # puts results.to_yaml
  # results.select!{ |car| car.f("features").include? LKAS }
  # results.sort_by!{ |car| car.f("pricingDetail").f("primary") }
  # retults

  puts "CARS FOUND:"
  p CARS_FOUND
end

main
