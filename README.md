# cloudhub_wrapper
---------

Post XML to a Cloudhub API.

## Installation

Add to your Gemfile

```ruby
gem 'cloudhub_wrapper'
```

bundle install

##Usage

Initialize a new CloudhubWrapper instance and pass in the endpoint, user and password.

```ruby
cloudhub = CloudhubWrapper.new("http://cloudhubendpoint.io/rest/v1/account", "web99", "password_here")
```

Set your xml string...

```ruby
cloudhub.xml = "<foo>bar</foo>"
```

... alternatively you can use the builder. This is very specific to the custom Cloudhub API we're integrating with, but it might give you a starting point to modifiy for your own use.

```ruby
cloudhub.build_xml(subscriber_instance, "channel_name", "origin_name", "http://schema.example.com/cloud/v1")
```

Post your xml to Cloudhub

```ruby
cloudhub.post_xml
```
