require 'spec_helper'

describe 'builder' do
  it 'should build empty bookmarks' do
    builder = Markio::Builder.new
    file_contents = builder.build_string
    file_contents.length.should_not be_nil
    file_contents.should match /DOCTYPE NETSCAPE-Bookmark-file-1/
  end

  it 'should build single bookmark without tags' do
    builder = Markio::Builder.new
    bookmark = Markio::Bookmark.new
    bookmark.title = "Test bookmark"
    bookmark.href = "http://test.com"
    builder.bookmarks << bookmark
    file_contents = builder.build_string
    file_contents.length.should_not be_nil
    file_contents.should match /Test bookmark/
    file_contents.should match /test\.com/
  end


  it 'should be able to parse what it builds' do
    #TODO
  end
end