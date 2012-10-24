require "markio/version"
require "markio/bookmark"
require "markio/parser"
require "markio/builder"
module Markio
  def Markio.parse(file)
    parser = Markio::Parser.new file
    parser.parse
  end
end
