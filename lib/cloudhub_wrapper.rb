class CloudhubWrapper

  require "net/https"
  require "uri"
  require "builder"
  require "rexml/document"
  

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
    address_elements = [
      [:address, "addressLine"],
      [:suburb, "suburb"],
      [:postcode, "postalcode"],
      [:post_code, "postalcode"],
      [:state, "state"]
    ]
    
    contact_elements = [
      [:first_name, "firstName"],
      [:last_name, "lastName"],
      [:email, "email"],
      [:mobile, "phone"],
      [:phone, "phone"]
    ]


    doc = REXML::Document.new(File.read("data/default.xml"))
    root = doc.root
    root.add_attributes({"interchangeDate" => Time.now.to_s, "xmlns:ns0" => schema})
    root.elements["ns0:account"].add_attributes({"id" => subscriber.email, "creationDateTime" => Time.now.to_s, "xmlns:ns0" => schema})
    root.elements[1].elements["ns0:address"]


    @xml = doc.to_s #turn this into xml 
    
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
