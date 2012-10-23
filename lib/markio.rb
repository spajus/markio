require "markio/version"
require "markio/bookmark"
require "markio/parser"
module Markio
  def Markio.parse(file)
    parser = Markio::Parser.new file
    parser.parse
  end
end
