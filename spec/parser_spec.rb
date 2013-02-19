require 'spec_helper'

module Markio
  describe Parser do
    it 'should parse single bookmark' do
      bookmarks = Markio.parse File.open "spec/assets/one_bookmark.html"

      bookmarks.should_not be_nil
      bookmarks.class.should be Array
      bookmarks.length.should eq 1
      bookmark = bookmarks[0]
      bookmark.title.should eq 'Save It - Simple, secure bookmarks'
      bookmark.href.should eq 'https://saveit.in/'
      bookmark.folders.length.should eq 1
      bookmark.folders.first.should eq "Bookmarking"
      bookmark.add_date.should_not be_nil
      bookmark.last_visit.should_not be_nil
      bookmark.last_modified.should_not be_nil
      bookmark.add_date.class.should be DateTime
      bookmark.last_visit.class.should be DateTime
      bookmark.last_modified.class.should be DateTime
    end

    it 'should parse multiple bookmarks' do
      bookmarks = Markio.parse File.open "spec/assets/many_bookmarks.html"
      bookmarks.length.should eq 11
      bookmarks.first.folders.length.should eq 1
      bookmarks.first.folders.first.should eq "Bookmarks Bar"
      bookmarks.last.folders.length.should eq 2
    end

    it 'should parse delicious bookmarks' do
      bookmarks = Markio.parse File.open "spec/assets/delicious_bookmarks.html"
      bookmarks.length.should eq 5
      bookmarks.first.folders.length.should eq 5
      bookmarks.first.folders.first.should eq "food"
      bookmarks.last.folders.length.should eq 3
    end

    it 'should parse nested bookmarks' do
      bookmarks = Markio.parse File.open "spec/assets/nested_bookmarks.html" 

      bookmarks.length.should eq 10
      bookmarks.first.folders.length.should eq 0
      bookmarks.last.folders.length.should eq 2
    end

    it 'should raise error for non existing files' do
      expect { Markio.parse File.open "spec/assets/not_found.html" }.to raise_error
    end

    it 'should handle corrupted data' do
      bookmarks = Markio.parse File.open "spec/assets/corrupted.html"
      bookmarks.should eq []
    end

  end
end
