class UrlNormalizer
  class Nu < UrlNormalizer
    normalize_for 'nu.nl'
    normalize_for 'www.nu.nl'

    def article_page?
      @uri.path.match(%r{\A/[-a-z0-9]+/[0-9]+/[-a-z0-9]+\.html\z})
    end

    def normalize
      return super unless article_page?

      @uri.path = @uri.path.gsub(%r{/[^/]+\.html\z}, '/')
      @uri.normalize

      @uri.to_s
    end
  end
end
