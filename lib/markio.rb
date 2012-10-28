require "markio/version"
require "markio/bookmark"
require "markio/parser"
require "markio/builder"
module Markio
  def self.parse(data)
    Parser.new(data).parse
  end
end
