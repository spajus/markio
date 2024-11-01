require 'nokogiri'

class Markio::Builder

  attr_accessor :bookmarks

  def initialize(options = {})
    @title = options[:title] || 'Bookmarks'
    @bookmarks = []
  end

  def build_string
    build
  end

  def build_file(file)
    File.new(file, 'w') do |f|
      f.write build
    end
  end

  private

  def build

    bookmarks = { nil => [] }
    @bookmarks.each do |b|

      if b.folders.any?
        b.folders.each do |f|
          bookmarks[f] ||= []
          bookmarks[f] << b
        end
      else
        bookmarks[nil] << b
      end
    end

    docparts = Nokogiri::HTML::DocumentFragment.parse ''
    Nokogiri::HTML::Builder.with(docparts) do |html|
      html.comment <<END
This is an automatically generated file.
It will be read and overwritten.
DO NOT EDIT!
END
      html.meta('HTTP-EQUIV' => 'Content-Type', 'CONTENT' => 'text/html; charset=UTF-8')
      html.title @title
      html.dl {
        html.p
        bookmarks.keys.each do |f|
          unless f.nil?
            html.dt {
              html.h3 f
              html.dl {
                html.p
                bookmarks[f].each { |b| build_bookmark html, b }
              }
            }
          else
            bookmarks[nil].each { |b| build_bookmark html, b }
          end
        end
      }
    end

  "<!DOCTYPE NETSCAPE-Bookmark-file-1>\n" << docparts.to_html
  end

  private

  def build_bookmark(html, b)
    html.dt {
      params = { :href => b.href }
      params[:add_date] = b.add_date.to_time.to_i if b.add_date
      params[:last_visit] = b.last_visit.to_time.to_i if b.last_visit
      params[:last_modified] = b.last_modified.to_time.to_i if b.last_modified
      params[:icon_uri] = b.icon_uri if b.icon_uri
      params[:icon] = b.icon if b.icon
      html.a(b.title, params)
    }
  end
end
