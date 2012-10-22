require 'nokogiri'
require 'date'
class Markio::BookmarksFile < Nokogiri::XML::SAX::Document

  attr_reader :bookmarks

  def initialize
    @bookmarks = []
    @folders = []
    @element = []
  end

  def start_element(element, attributes)
    @element << element.downcase
    case element.downcase
      when 'a'
        data = {}
        Hash[*attributes.flatten].each do |k, v|
          data[k.downcase] = v
        end
        @bookmark = Markio::Bookmark.new
        @bookmark.href = data['href']
        @bookmark.folders = Array.new @folders
        @bookmark.add_date = parse_timestamp data['add_date']
        @bookmark.last_visit = parse_timestamp data['last_visit']
        @bookmark.last_modified = parse_timestamp data['last_modified']
    end

  end

  def characters(data)
    case @element.last
      when 'a'
        @bookmark.title = data
      when 'h3'
        @folders << data
    end

  end

  def end_element(element)
    el = @element.pop
    case element.downcase
      when 'a'
        @bookmarks << @bookmark
        @bookmark = nil
      when 'dl'
        @folders.pop
    end
  end

  private

  def parse_timestamp(timestamp)
    Time.at(timestamp.to_i).to_datetime if timestamp
  end

end
