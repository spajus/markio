require 'spec_helper'

describe Markio::Parser do

  it 'should parse single bookmark' do
    parser = Markio::Parser.new("spec/test_data/one_bookmark.html")
    bookmarks = []
    parser.each { |b| bookmarks << b }

    bookmarks.should_not be_nil
    bookmarks.class.should be Array
    bookmarks.length.should eq 1
    bookmark = bookmarks[0]
    bookmark.title.should eq 'Save It - Simple, secure bookmarks'
    bookmark.href.should eq 'https://saveit.in/'
    bookmark.folders.length.should eq 0
    bookmark.add_date.should_not be_nil
    bookmark.last_visit.should_not be_nil
    bookmark.last_modified.should_not be_nil
    bookmark.add_date.class.should be DateTime
    bookmark.last_visit.class.should be DateTime
    bookmark.last_modified.class.should be DateTime
  end

  it 'should parse multiple bookmarks' do
    parser = Markio::Parser.new("spec/test_data/many_bookmarks.html")
    bookmarks = []
    parser.each { |b| bookmarks << b }
  end

end