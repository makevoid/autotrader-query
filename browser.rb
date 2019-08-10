require 'yaml'

search_name = "prius_red"

cars = YAML::load_file"./found_#{search_name}.yml"
cars.each_with_index do |car, idx|
  link = car.fetch :link
  # puts link
  puts system "google-chrome #{link}"
  # exit if idx > 10
end
