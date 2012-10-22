require "markio/version"
require "markio/bookmarks_file"
require "markio/bookmark"
module Markio
  def Markio.parse(file)
    file = File.open(file) unless file.is_a? File
    bookmarks = Markio::BookmarksFile.new
    parser = Nokogiri::XML::SAX::Parser.new(bookmarks)
    xml = Nokogiri::XML(file).to_xml
    parser.parse(xml)
    bookmarks.bookmarks
  end
end
