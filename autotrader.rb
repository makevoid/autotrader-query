require_relative 'env'

def query(params:)
  params = Rack::Utils.build_query params
  Get.g "#{API_HOST}#{API_PATH}?#{params}"
end

def default_params
  {
    startYear:    2015,
    endYear:      2019,
    sellerTypes:  "p",   # private sellers (comment this)
    maxPrice:     16000, # 16k - stay "cheap"
    sortBy:       "derivedpriceASC",
    numRecords:   20000,
    firstRecord:  0,
  }
end

def main
  params  = default_params
  results = query params: params
  puts "Results:"
  puts results.to_yaml
end

main
