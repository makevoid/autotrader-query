# ruby is already present on mac
# install ruby on windows https://rubyinstaller.org
# if you're on linux, you probably know how to `apt install ruby` on your favourite distro


# we're going to build a script to fetch

# 1.

$ gem i nokogiri

# a bit slow to install (c deps) but a very good api for html parsing

# ....

# quick demo of ruby and nokogiri before we start

# open the terminal (in your Applications, Utilities directory, Terminal app)

# open IRB

require 'nokogiri'

# this will tell you that nokogiri is loaded

# nokogiri requires the `Nokogiri` class

irb(main):002:0> Nokogiri
=> Nokogiri


#

Nokogiri::HTML("<p></p>")


#

Nokogiri::HTML("<p>test</p>")

#

Nokogiri::HTML("<p>test</p>")

#

Nokogiri::HTML("<p>test</p>").inner_text

#

# -----------------

irb(main):006:0> require 'net/http'
=> true

# ------

irb(main):007:0> require 'json'
=> true

# ------

irb(main):008:0> Net
=> Net

# ------

irb(main):009:0> Net::HTTP
=> Net::HTTP

# ------

irb(main):010:0> URI
=> URI

# ------

irb(main):011:0> JSON
=> JSON

# ------



# 2.

# procedural ruby (in this tutorial we're going to see how to build a simple program with procedural ruby)

# ruby is highly OO but let's not

# in this tutorial i'm assuming you know the basics of a programming language - any programming language

require 'net/http' # let's assume ruby `require` works similarly to other `import/require` of other languages and forget about this
require 'json'

# we're requiring Net::HTTP (:: is how to namespace in ruby)

# let's define a new function:

def get(url)
  uri  = URI url
  resp = Net::HTTP.get_response uri
  body = resp.body
  JSON.parse body
end

Get = (body) -> {
  uri  = URI url
  resp = Net::HTTP.get_response uri
  body = resp.body
  JSON.parse body
}

# -----

API_HOST = "https://www.autotrader.co.uk"
SEARCH_URL = "#{API_HOST}/results-car-search"

page   = 0
params = "page=#{page}"
url    = "#{API_HOST}#{SEARCH_URL}?#{params}"
resp   = get url # json response
html   = resp.fetch "html" # containing HTML (weird :D)
dom    = Nokogiri::HTML html

# dom.search()...

# -----
