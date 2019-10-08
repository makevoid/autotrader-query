# final ruby bit

# next --- refactor it in a function, and then in a class

API_HOST = "https://www.autotrader.co.uk"
SEARCH_URL = "#{API_HOST}/results-car-search"

page   = 0
params = "page=#{page}"
url    = "#{API_HOST}#{SEARCH_URL}?#{params}"
resp   = get url # json response
html   = resp.fetch "html" # containing HTML (weird :D)
dom    = Nokogiri::HTML html

# dom.search()...
