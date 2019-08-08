require 'json'
require 'yaml'
require 'net/http'
require 'bundler'
Bundler.require :default
require_relative 'config'
require_relative 'lib/get'

API_HOST = "https://www.autotrader.co.uk"
API_PATH = "/results-car-search"

API_PATH_INIT = "/json/fpa/initial"
API_PATH_DERIV = "/json/taxonomy/technical-specification?derivative="

include Config
