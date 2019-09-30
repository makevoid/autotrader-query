# ruby is already present on mac
# install ruby on windows https://rubyinstaller.org
# if you're on linux, you probably know how to `apt install ruby` on your favourite distro

# 1.

# gem i nokogiri

# a bit slow to install (c deps) but a very good api for html parsing

# ....


# 2.

# procedural ruby (in this tutorial we're going to see how to build a simple program with procedural ruby)

# ruby is highly OO but let's not

# in this tutorial i'm assuming you know the basics of a programming language - any programming language

require 'net/http' # let's assume ruby `require` works similarly to other `import/require` of other languages and forget about this
require 'json'

# we're requiring Net::HTTP (:: is how to namespace in ruby)

# let's define a new function:

def get
  uri  = URI url
  resp = Net::HTTP.get_response uri
  body = resp.body
  JSON.parse body
end

URL = "https://www.autotrader.co.uk/results-car-search"

page   = 0
params = "page=#{page}"
url    = "#{API_HOST}#{API_PATH}?#{params}"
body = get url
html = body.fetch "html"

dom = Nokogiri::HTML html
