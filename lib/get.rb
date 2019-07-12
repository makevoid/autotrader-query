class Get
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def get
    puts "URL: #{url}"
    # body = get_net
    body = get_mechanize
    JSON.parse body
  end

  def get_net
    uri  = URI url
    resp = Net::HTTP.get_response uri
    resp.body
  end

  def get_net
    uri  = URI url
    resp = Net::HTTP.get_response uri
    resp.body
  end
  Mozilla/5.0 (Android 4.4; Mobile; rv:41.0) Gecko/41.0 Firefox/41.0


  # Agent = Mechanize.new
  # Agent.user_agent = "Mac Firefox" # lol
  #
  # def get_mechanize
  #   resp = Agent.get url
  #   resp.body
  # end

  def self.g(url)
    new(url).get
  end
end
