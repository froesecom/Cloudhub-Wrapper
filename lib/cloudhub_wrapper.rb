class CloudhubWrapper

  require "net/https"
  require "uri"
  require "builder"

  def initialize(endpoint, user, password)
    @endpoint = endpoint
    @user     = user
    @password = password
  end

  def xml
    @xml
  end

  def xml=(xml)
    @xml = xml
  end

  def build_xml(subscriber, channel, origin, schema)
    #@xml = 
  end

  def post_xml
    if @xml
      uri           = URI.parse(@endpoint)
      request       = Net::HTTP::Post.new(uri.path)
      request.body  = @xml
      request.basic_auth(@user, @password)
      http          = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl  = true
      response      = http.request(request)
    else
      #throw an error of some description
    end

  end

end
