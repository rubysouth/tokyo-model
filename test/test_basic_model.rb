require 'test_helper'
require File.dirname(__FILE__) + "/fixtures/post.rb"

class TestBasicModel < Test::Unit::TestCase

  setup do
    FileUtils.rm_f dbpath
    TokyoModel::Database.create(dbpath)
    TokyoModel::Database.open("file://#{dbpath}")
    @post = Post.new
    @post.title = "First post!"
    @post.body = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    @post.author = "John Doe"
    @post.permalink = "http://example.org/posts/1"
    @post.put
  end

  teardown do
    !TokyoModel::DATABASES.empty? && TokyoModel::DATABASES.first.close
    FileUtils.rm_f dbpath
  end
  
  context "a model" do
    
    should "have a db connection" do
      assert_not_nil Post.db
    end
    
    should "be gettable" do
      post2 = Post.get(@post.id)
      assert_equal @post.title, post2.title 
    end
    
    should "generate an id when persisted" do
      post = Post.new
      post.title = "test"
      post.put
      assert_not_nil post.id
    end
    
  end
  
  context "a model instance" do
    should "be equal to another instance of the same class with the same id" do
      assert_equal @post, Post.get(@post.id)
    end
  end
  
end