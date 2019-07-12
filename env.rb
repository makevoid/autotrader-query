require 'json'
require 'yaml'
require 'net/http'
require 'bundler'
Bundler.require :default
require_relative 'lib/get'

API_HOST = "https://www.autotrader.com"
API_PATH = "/rest/searchresults/base"
