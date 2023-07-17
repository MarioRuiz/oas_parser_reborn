require 'json'
require 'uri'
require 'yaml'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/conversions'
require 'nokogiri'

require 'addressable/uri'
require 'deep_merge'

require_relative 'oas_parser_reborn/path.rb'
require_relative 'oas_parser_reborn/payload.rb'
require_relative 'oas_parser_reborn/raw_accessor.rb'
require_relative 'oas_parser_reborn/abstract_attribute.rb'

Dir["#{File.dirname(__FILE__)}/oas_parser_reborn/**/*.rb"].each do |file|
  require file
end

module OasParser
  # Your code goes here...
end
