module GGeocode
### ref: http://code.google.com/apis/maps/documentation/geocoding/

  GGeocode::Version = '0.0.3'

  def GGeocode.version
    GGeocode::Version
  end

  require 'net/http'
  require 'uri'
  require 'cgi'

  begin
    require 'rubygems'
    gem 'yajl-ruby'
    gem 'map'
  rescue LoadError
    nil
  end

  require 'yajl/json_gem'
  require 'map'

  AddressPattern = /\w/iox

  def geocode(*args, &block)
    options = Map.options_for!(args)
    if options[:reverse]
      args.push(options)
      return reverse_geocode(*args, &block)
    end
    string = args.join(' ')
    address = address_for(string)
    response = get(url_for(:address => address))
    result_for(response)
  end

  def reverse_geocode(*args, &block)
    options = Map.options_for!(args)
    string = args.join(' ')
    latlng = latlng_for(string)
    response = get(url_for(:latlng => latlng))
    result_for(response)
  end
  alias_method('rgeocode', 'reverse_geocode')

  def GGeocode.call(*args, &block)
    options = Map.options_for!(args)
    string = args.join(' ')
    reverse = string !~ AddressPattern || options[:reverse]
    reverse ? GGeocode.reverse_geocode(string) : GGeocode.geocode(string)
  end

  def latlng_for(string)
    lat, lng = string.scan(/[^\s,]+/)
    latlng = [lat, lng].join(',')
  end

  def address_for(string)
    string.to_s.strip
  end

  def result_for(response)
    return nil unless response
    hash = JSON.parse(response.body)
    return nil unless hash['status']=='OK'
    map = Map.new
    map.extend(Response)
    map.response = response
    map['status'] = hash['status']
    map['results'] = hash['results']
    map
  end

  module Response
    attr_accessor :response
    def body
      response.body
    end
    alias_method('json', 'body')
  end

  Url = URI.parse("http://maps.google.com/maps/api/geocode/json?")

  def url_for(options = {})
    options[:sensor] = false unless options.has_key?(:sensor)
    url = Url.dup
    url.query = query_for(options)
    url
  end

  def query_for(options = {})
    pairs = [] 
    options.each do |key, values|
      key = key.to_s
      values = [values].flatten
      values.each do |value|
        value = value.to_s
        if value.empty?
          pairs << [ CGI.escape(key) ]
        else
          pairs << [ CGI.escape(key), CGI.escape(value) ].join('=')
        end
      end
    end
    pairs.replace pairs.sort_by{|pair| pair.size}
    pairs.join('&')
  end

  def get(url)
    url = URI.parse(url.to_s) unless url.is_a?(URI)
    begin
      Net::HTTP.get_response(url)
    rescue SocketError, TimeoutError
      return nil
    end
  end

  extend(GGeocode)
end

module Kernel
private
  def GGeocode(*args, &block)
    GGeocode.call(*args, &block)
  end
end

Ggeocode = GGeocode

BEGIN {
  if defined?(GGeocode)
    Object.send(:remove_const, :GGeocode)
    Object.send(:remove_const, :Ggeocode)
  end
}


if $0 == __FILE__
  require 'pp'

  pp(GGeocode.geocode('boulder, co'))
  pp(GGeocode.rgeocode('40.0149856,-105.2705456'))
end





__END__

{ 
  "status": "OK",

  "results": [ {
    "types": [ "locality", "political" ],

    "formatted_address": "Boulder, CO, USA",

    "address_components": [ {
      "long_name": "Boulder",
      "short_name": "Boulder",
      "types": [ "locality", "political" ]
    }, {
      "long_name": "Boulder",
      "short_name": "Boulder",
      "types": [ "administrative_area_level_2", "political" ]
    }, {
      "long_name": "Colorado",
      "short_name": "CO",
      "types": [ "administrative_area_level_1", "political" ]
    }, {
      "long_name": "United States",
      "short_name": "US",
      "types": [ "country", "political" ]
    } ],

    "geometry": {
      "location": {
        "lat": 40.0149856,
        "lng": -105.2705456
      },
      "location_type": "APPROXIMATE",
      "viewport": {
        "southwest": {
          "lat": 39.9465862,
          "lng": -105.3986050
        },
        "northeast": {
          "lat": 40.0833165,
          "lng": -105.1424862
        }
      },
      "bounds": {
        "southwest": {
          "lat": 39.9640689,
          "lng": -105.3017580
        },
        "northeast": {
          "lat": 40.0945509,
          "lng": -105.1781970
        }
      }
    }
  } ]
}

