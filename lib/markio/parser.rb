require 'nokogiri'
class Markio::Parser

  include Enumerable

  def initialize(file)
    file = File.open(file) unless file.is_a? File
    @document = Nokogiri::HTML(file)
  end

  def each
    node = @document.at_xpath('//html/body')
    @folders = []
    traverse(node) { |bookmark| yield bookmark }
  end

  private

  def traverse(node, &block)
    bookmarks = node.search './dt//a'
    folder_names = node.search './dt/h3'
    folder_items = node.search './dl'

    bookmarks.each do |data|
      bookmark = Markio::Bookmark.new
      bookmark.title = data.text
      bookmark.href = data['href']
      bookmark.folders = Array.new(@folders)
      yield bookmark
    end

    folder_items.size.times do |i|
      folder_name = folder_names[i]
      folder_item = folder_items[i]
      @folders << folder_name unless folder_name.nil?
      traverse(folder_item, &block)
    end

  end

end
