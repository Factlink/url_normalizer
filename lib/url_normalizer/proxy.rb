require 'andand'

class UrlNormalizer
  class Proxy < UrlNormalizer
    normalize_for 'fct.li'

    def normalize
      url = @uri.query && CGI.parse(@uri.query)['url'].andand[0]
      if url
        UrlNormalizer.normalize url
      else
        super
      end
    end
  end
end
