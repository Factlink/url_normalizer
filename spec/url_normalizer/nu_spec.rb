require_relative '../../lib/url_normalizer.rb'
require 'uri'
require 'base64'

describe UrlNormalizer do
  describe ".normalize" do
    def normalized url
      UrlNormalizer.normalize(url)
    end
    it do
      normalized('http://www.nu.nl/muziek/3609857/anouk-verbluffend-bij-bescheiden-symphonica-in-rosso.html').should ==
                 'http://www.nu.nl/muziek/3609857/'
    end

    it do
      normalized('http://www.nu.nl/colofon.html').should ==
                 'http://www.nu.nl/colofon.html'
    end
  end
end
