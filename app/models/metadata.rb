require 'open-uri'

class Metadata
  attr_reader :doc
  def self.retrieve_data(url)
    new URI.open(url)
  end
  def initialize html=nil
    @doc = Nokogiri::HTML html
  end
  def attributes
    {
      title: title,
      desc: desc,
      image: image
    }
  end
  def title
    doc.at_css('title')&.text
  end
  def desc
    meta_tag_content "name='description'"
  end
  def image
    meta_tag_content "property='og:image'"
  end
  def meta_tag_content attr
    doc.at_css("meta[#{attr}]")&.attributes&.fetch('content', nil)&.value
  end
end