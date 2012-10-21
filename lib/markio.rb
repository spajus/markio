require "markio/version"
require "markio/parser"
require "markio/bookmark"
require "markio/folder"
module Markio
  def parse(file)
    parser = Markio::Parser.new(file)
    result = []
    parser.each { |bookmark| result << bookmark }
    result
  end
end
