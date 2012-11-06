require 'date'
class Markio::Bookmark

  attr_accessor :title, :href, :add_date, :last_visit, :last_modified, :folders

  def self.create data
    bookmark = new
    bookmark.title = data[:title]
    bookmark.href = data[:href]
    bookmark.add_date = data[:add_date] || DateTime.now
    bookmark.last_visit = data[:add_date]
    bookmark.last_modified = data[:last_modified]
    bookmark.folders = data[:folders] || []
    bookmark
  end

  def == other
    unless other.nil? or other.class != self.class
      other.href == href and other.title == title
    end
  end
end
