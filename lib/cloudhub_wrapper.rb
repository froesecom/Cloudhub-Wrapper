class CloudhubWrapper

  require "net/https"
  require "uri"
  require "rexml/document"
  

  def initialize(endpoint, user, password)
    @endpoint = endpoint
    @user     = user
    @password = password
  end

  attr_accessor :xml

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


    doc        = REXML::Document.new(File.read(File.join(File.dirname(__FILE__), "..", "data", "default.xml")))
    root       = doc.root
    address_el = root.elements[1].elements["ns0:address"]
    contact_el = root.elements[1].elements["ns0:contact"]
    
    root.add_attributes({"interchangeDate" => Time.now.to_s, "xmlns:ns0" => schema})
    root.elements["ns0:account"].add_attributes({"id" => subscriber.email, "creationDateTime" => Time.now.to_s, "xmlns:ns0" => schema})
    contact_el.elements["ns0:channelContactPreferences"].children[1].add_attributes({"channel" => channel, "origin" => origin })

    address_elements.each do |array|
      if subscriber.respond_to? array[0]
        el = REXML::Element.new("ns0:#{array[1]}", address_el)
        el.add_text(subscriber.send(array[0]))
      end
    end

    contact_elements.each do |array|
      if subscriber.respond_to? array[0]
        el = REXML::Element.new("ns0:#{array[1]}", contact_el)
        el.add_text(subscriber.send(array[0]))
      end
    end


    @xml = doc.to_s
    
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
