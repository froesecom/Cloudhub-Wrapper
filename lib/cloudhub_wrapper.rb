class CloudhubWrapper

  require "net/https"
  require "uri"

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
    @xml = "<ns0:accountInterchange interchangeControlNo='00000001' agreementName='SF.LE' senderQualifier='ZZ' senderId='LE' receiverQualifier='ZZ' receiverId='SF' interchangeDate='#{ Time.now.to_s }' xmlns:ns0='#{schema}'>
              <ns0:account id='#{ subscriber.email }' domain='external' type='Retail Account'  creationDateTime='#{ Time.now.to_s }' xmlns:ns0='#{schema}'>
                <ns0:address addressType='home'>
                  <ns0:addressLine>#{ subscriber.address }</ns0:addressLine>
                  <ns0:suburb>#{ subscriber.suburb }</ns0:suburb>
                  <ns0:postalcode>#{ subscriber.postcode }</ns0:postalcode>
                  <ns0:state>#{ subscriber.state }</ns0:state>
                  <ns0:country isoCountryCode='AU'>Australia</ns0:country>
                </ns0:address>
                <ns0:contact contactRole='requestor'>
                  <ns0:firstName>#{ subscriber.first_name }</ns0:firstName>
                  <ns0:lastName>#{ subscriber.last_name }</ns0:lastName'
                  <ns0:email>#{ subscriber.email }</ns0:email>
                  <ns0:phone>#{ subscriber.mobile }</ns0:phone>
                  <ns0:contactPreference contactVia='Email' contactOption='OptIn'/>
                <ns0:channelContactPreferences>
                  <ns0:channelContactPreference channel='#{ channel }' contactOption='optIn' origin='#{ origin }'/>
                </ns0:channelContactPreferences>
              </ns0:contact>
              </ns0:account>
            </ns0:accountInterchange>"
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
