require 'yaml'

search_name = "prius_white"

chrome = "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome" # osx
# chrome = "google-chrome" # linux

cars = YAML::load_file"./found_#{search_name}.yml"
cars.each_with_index do |car, idx|
  link = car.fetch :link
  # puts link
  puts system "\"#{chrome}\" #{link}"
  # exit if idx > 10
end
