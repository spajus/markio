require 'nokogiri'
require 'date'
class Markio::Parser

  def initialize(file)
    file = File.open(file) unless file.is_a? File
    @document = Nokogiri::HTML(file)
  end

  def parse
    bookmarks = []
    traverse(@document, []) do |bookmark|
      bookmarks << bookmark
    end
    bookmarks
  end

  private

  def traverse(node, folders, &block)
    node.xpath("./*").each do |child|
      case child.name.downcase
        when 'dl'
          traverse child, folders, &block
          folders.pop
        when 'a'
          yield parse_bookmark(child, folders)
        when 'h3'
          folders << child.text
        else
          if child.children.any?
            traverse child, folders, &block
          end
      end
    end

  end

  def parse_bookmark(node, folders)
    data = {}
    node.attributes.each do |k, a|
      data[k.downcase] = a.value
    end
    bookmark = Markio::Bookmark.new
    bookmark.href = data['href']
    bookmark.title = node.text
    bookmark.folders = Array.new folders
    bookmark.add_date = parse_timestamp data['add_date']
    bookmark.last_visit = parse_timestamp data['last_visit']
    bookmark.last_modified = parse_timestamp data['last_modified']
    bookmark
  end

  def parse_timestamp(timestamp)
    Time.at(timestamp.to_i).to_datetime if timestamp
  end

end
