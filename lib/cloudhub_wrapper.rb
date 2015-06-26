class CloudhubWrapper

  require "net/https"
  require "uri"

  def initialize(endpoint, user, password)
    @endpoint = endpoint
    @user     = user
    @password = password
  end

  def build_xml(channel, origin, schema)
    ApplicationController.new.render_to_string(:partial => "opt_in", :locals => {:subscriber => subscriber, :channel => channel, :origin => origin})
  end

  def post_xml(subscriber, channel, origin)
    uri           = URI.parse(@endpoint)
    request       = Net::HTTP::Post.new(uri.path)
    request.body  = @xml
    request.basic_auth(@user, @password)
    http          = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl  = true
    response      = http.request(request)

  end

end
