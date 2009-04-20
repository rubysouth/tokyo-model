$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'uri'
require 'tokyocabinet'
require 'tokyo_model/persistable'
require 'tokyo_model/adapters/abstract_adapter'
require 'tokyo_model/query'

module TokyoModel

  VERSION = '0.0.3'
  ADAPTERS = [:file, :tyrant].freeze
  DATABASES = []

  # Connect to the database. Accepts a uri and optional list of open modes:
  #
  #   TokyoModel.connect("file:/tmp/database.tdb", :read, :write, :create, :truncate)
  #   TokyoModel.connect("tyrant://localhost:1978")
  #   TokyoModel.connect("unix://host/var/sock/tyrant.sock")
  #
  # The permitted URI schemas are: +file+, +tyrant+ and +unix+.
  def self.open(*args)
    uri = URI::parse(args.shift)
    DATABASES << adapter(uri.scheme).new(uri, *args)
  end

  def self.close
    DATABASES.each { |d| d.close }
  end
  
  def self.query
    Query.new(DATABASES.first)
  end

  private

  def self.adapter(scheme)
    class_name = scheme == "unix" ? "tyrant" : scheme
    require "tokyo_model/adapters/#{class_name}"
    TokyoModel::Adapters.const_get(class_name.titleize.to_sym)
  end

end

class String
  def titleize
    self.gsub(/\b([a-z])/) { |x| x[-1..-1].upcase }
  end
end