class Get
  attr_reader :url

  def initialize(url)
    @url = url
  end

  # or with get_response()

  def get
    uri  = URI url
    resp = Net::HTTP.get_response uri
    body = resp.body
    JSON.parse body
  end


  def self.g(url)
    new(url).get
  end

  # USE THIS CODE FOR MECHANIZE SEARCH

  # net-http get w/ user agent header

  # USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/42.0"
  #
  # def request(uri:)
  #   req = Net::HTTP::Get.new uri
  #   req['User-Agent'] = USER_AGENT
  #   req['Accept'] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"
  #   req
  # end
  #
  # def get_net
  #   uri = URI url
  #   req = -> (http) { http.request request(uri: uri) }
  #   res = Net::HTTP.start(uri.hostname, uri.port){ |http| req.(http) }
  #   res.body
  # end


  # or with mechanize ("magical" user agents + libxml2/nokogiri dom parsing support)

  # Agent = Mechanize.new
  # # Agent.user_agent = "Mac Firefox" # lol
  #
  # def get_mechanize
  #   resp = Agent.get url
  #   resp.body
  # end

end
