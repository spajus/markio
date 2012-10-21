require 'rspec'
require 'markio'
require 'pry'
require 'pry-nav'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end