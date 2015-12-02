require 'addressable/uri'

class SearchGoogleJob < ActiveJob::Base
  attr_accessor :doc, :keyword

  queue_as :default

  def perform(keyword)
    html_source = crawl_html_search_page(keyword.text)
    self.doc = Nokogiri::HTML(html_source)

    data = Hash.new
    data[:html_source] = html_source # Page source
    data[:total_result] = total_search_result # Total of search results
    data[:total_links_count] = links_count # Total number of links
    data[:adwords_attributes] = fetch_adwords # AdWords result
    data[:non_adwords_attributes] = fetch_non_adwords # Non-AdWords result

    keyword.update_attributes(data)
  end

  def crawl_html_search_page(keyword)
    keyword = keyword.gsub(/\s/, '+') # replace space with '+'
    url = Addressable::URI.parse("https://www.google.com/search?q=#{keyword}")
    source = open(url.normalize, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE).read

    # TODO: improve performance
    # This will make result link work correctly, but shitty performance issue
    # source.gsub!(/(href|src)="\//, '\1="https://google.com/')
    source
  end

  def total_search_result
    doc.css('#resultStats').text
  end

  def fetch_adwords
    top_adwords = doc.css('#center_col li.ads-ad').map do |li|
      { title: li.css('h3').first.text, url: li.css('cite').first.text, position: Adword.positions[:top] }
    end

    right_adwords = doc.css('#rhs_block li.ads-ad').map do |li|
      { title: li.css('h3').first.text, url: li.css('cite').first.text, position: Adword.positions[:right] }
    end

    top_adwords + right_adwords
  end

  def fetch_non_adwords
    doc.css('#search .g').map do |li|
      { title: li.css('h3').first.text, url: li.css('cite').text }
    end
  end

  def links_count
    doc.css('a').size
  end
end
