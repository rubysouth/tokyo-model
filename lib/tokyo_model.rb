$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'uri'
require 'tokyocabinet'
require 'tokyo_model/database'
require 'tokyo_model/persistable'

module TokyoModel
  VERSION = '0.0.1'
end