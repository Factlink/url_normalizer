require "url_normalizer/version"
require 'addressable/uri'
require 'cgi'

class UrlNormalizer
  @@normalizer_for = Hash.new(UrlNormalizer)

  def self.normalize_for domain
    @@normalizer_for[domain] = self
  end

  def self.normalize url
    url.sub!(/#(?!\!)[^#]*$/,'')

    uri = Addressable::URI.parse(url)

    @@normalizer_for[uri.host].new(uri).normalize
  end

  def initialize uri
    @uri = uri
  end

  def normalize
    uri = @uri

    uri.query = clean_query(uri.query)
    uri.normalize!

    url = uri.to_s
    url.sub(/\?$/,'')
  end

  def forbidden_uri_params
    [:utm_source, :utm_content, :utm_medium, :utm_campaign,

      # See https://stackoverflow.com/questions/12028116/facebook-like-referral-clicks-adding-variables-not-recognising-the-page-linke
      # and https://stackoverflow.com/questions/11668126/has-facebook-replaced-the-fb-ref-parameter
      :fb_source, :fb_action_ids, :fb_action_types,
      :fb_ref, :action_ref_map, :action_object_map, :action_type_map,
    ]
  end

  def whitelisted_uri_params
    nil
  end

  def clean_query query
    return unless query

    uri_params = CGI.parse(query)

    if forbidden_uri_params
      forbidden_params = forbidden_uri_params.map(&:to_s)
      uri_params.reject! {|k,v| forbidden_params.include? k}
    end

    if whitelisted_uri_params
      allowed_params = whitelisted_uri_params.map(&:to_s)
      uri_params.select! {|k,v| allowed_params.include? k}
    end

    build_query(uri_params)
  end

  def encode_component component
    Addressable::URI.encode_component component
  end

  def build_query(params)
    params.map do |name,values|
      escaped_name = encode_component name
      if values.length > 0
        values.map do |value|
          escaped_value = encode_component value
          "#{escaped_name}=#{escaped_value}"
        end
      else
        ["#{escaped_name}"]
      end
    end.flatten.join("&")
  end
end

require_relative 'url_normalizer/proxy'
require_relative 'url_normalizer/new_york_times'
require_relative 'url_normalizer/think_progress'
require_relative 'url_normalizer/linkedin'
require_relative 'url_normalizer/newyorker'
require_relative 'url_normalizer/nu'
