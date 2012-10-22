require 'nokogiri'
require 'date'
class Markio::Parser

  include Enumerable

  def initialize(file)
    file = File.open(file) unless file.is_a? File
    @document = Nokogiri::HTML(file)
  end

  def each
    node = @document.at_xpath('//html/body')
    traverse(node, []) { |bookmark| yield bookmark }
  end

  private

  def traverse(node, folders, &block)
    bookmarks = node.search './dt//a'
    folder_names = node.search './dt/h3'
    folder_items = node.search './dl'

    bookmarks.each do |data|
      bookmark = Markio::Bookmark.new
      bookmark.title = data.text
      bookmark.href = data['href']
      bookmark.folders = Array.new(folders)
      bookmark.add_date = parse_timestamp data['add_date']
      bookmark.last_visit = parse_timestamp data['last_visit']
      bookmark.last_modified = parse_timestamp data['last_modified']
      yield bookmark
    end

    folder_items.size.times do |i|
      folder_name = folder_names[i]
      folder_item = folder_items[i]
      next_folders = Array.new(folders)
      next_folders << folder_name.text unless folder_name.nil?
      traverse(folder_item, next_folders, &block)
    end

  end

  def parse_timestamp(timestamp)
    Time.at(timestamp.to_i).to_datetime if timestamp
  end

end
