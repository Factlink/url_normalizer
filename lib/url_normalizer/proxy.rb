class UrlNormalizer
  class Proxy < UrlNormalizer
    normalize_for 'fct.li'

    def normalize
      url = CGI.parse(@uri.query)['url'][0]
      UrlNormalizer.normalize url
    end
  end
end
