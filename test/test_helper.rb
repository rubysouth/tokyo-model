$VERBOSE = false
require 'rubygems'
require 'fileutils'
require 'test/unit'
require 'contest'

require File.dirname(__FILE__) + '/../lib/tokyo_model'
require File.dirname(__FILE__) + "/fixtures/post.rb"

def tmpdir
  @tmpdir ||= File.join(File.dirname(File.expand_path(__FILE__)), "tmp")
end

def dbpath
  "#{tmpdir}/test.tdb"
end

def load_fixtures
  @post = Post.new
  @post.title = "First post!"
  @post.body = "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
  @post.author = "John Doe"
  @post.permalink = "http://example.org/posts/1"
  @post.save
end

FileUtils.mkdir_p tmpdir
TokyoModel.open("file:#{dbpath}", :write, :read, :create, :truncate)
