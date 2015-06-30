class Subscriber
  attr_accessor :first_name, :last_name, :email, :address, :mobile, :suburb, :postcode, :state
  
  def initialize(first_name="test_first", last_name="test_last", email="email@email.com", address="test address", mobile="1233456789", suburb="test suburb", postcode="1234", state="state")
    @first_name, @last_name, @email = first_name, last_name, email
    @address, @mobile, @suburb      = address, mobile, suburb
    @postcode, @state               = postcode, state
  end

end