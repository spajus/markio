require 'spec_helper'
require 'date'

module Markio
  describe Builder do
    it 'should build empty bookmarks' do
      builder = Builder.new
      file_contents = builder.build_string
      file_contents.length.should_not be_nil
      file_contents.should match "DOCTYPE NETSCAPE-Bookmark-file-1"
    end

    it 'should build single bookmark without tags' do
      builder = Builder.new
      builder.bookmarks << Bookmark.create({
        :title => "Test bookmark",
        :href => "http://test.com",
        :add_date => Date.parse('2012-01-12 11:22:33').to_datetime,
        :last_visit => Date.parse('2012-01-13 10:20:30').to_datetime,
        :last_modified => Date.parse('2012-01-14 10:21:31').to_datetime
      })
      file_contents = builder.build_string
      file_contents.length.should_not be_nil
      file_contents.should match "Test bookmark"
      file_contents.should match "test\.com"
      file_contents.should match "add_date"
      file_contents.should match "last_visit"
      file_contents.should match "last_modified"
    end


    it 'should be able to parse what it builds' do
      builder = Builder.new
      builder.bookmarks << Bookmark.create({
        :title => "Test bookmark",
        :href => "http://test.com"
      })
      builder.bookmarks << Bookmark.create({
        :title => "Test bookmark",
        :href => "http://test.com",
        :add_date => Date.parse('2012-01-12 11:22:33').to_datetime,
        :last_visit => Date.parse('2012-01-13 10:20:30').to_datetime,
        :last_modified => Date.parse('2012-01-14 10:21:31').to_datetime
      })
      file_contents = builder.build_string
      bookmarks = Markio.parse file_contents
      bookmarks.length.should eq builder.bookmarks.length
      bookmarks.each do |b|
        builder.bookmarks.should include b
      end
    end

    it 'should be reflexive' do
      builder = Builder.new
      builder.bookmarks << Bookmark.create({
        :title => "Test bookmark",
        :href => "http://test.com"
      })
      builder.bookmarks << Bookmark.create({
        :title => "Test bookmark",
        :href => "http://test.com",
        :add_date => Date.parse('2012-01-12 11:22:33').to_datetime,
        :last_visit => Date.parse('2012-01-13 10:20:30').to_datetime,
        :last_modified => Date.parse('2012-01-14 10:21:31').to_datetime
      })
      file_contents = builder.build_string
      bookmarks = Markio.parse file_contents
      builder = Builder.new
      builder.bookmarks = bookmarks
      builder.build_string.should eq file_contents
    end
  end
end
