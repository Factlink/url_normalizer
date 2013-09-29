class UrlNormalizer
  class Proxy < UrlNormalizer
    normalize_for 'fct.li'

    def normalize
      return super unless @uri.query
      actual_urls = CGI.parse(@uri.query)['url']
      if actual_urls
        UrlNormalizer.normalize actual_urls[0]
      else
        super
      end
    end
  end
end
