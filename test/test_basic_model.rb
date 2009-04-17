require 'test_helper'
require File.dirname(__FILE__) + "/fixtures/post.rb"

class TestBasicModel < Test::Unit::TestCase

  setup do
    TokyoModel.open("file:#{dbpath}", :write, :read, :create, :truncate)
    @post = Post.new
    @post.title = "First post!"
    @post.body = "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
    @post.author = "John Doe"
    @post.permalink = "http://example.org/posts/1"
    @post.put
  end

  teardown do
    TokyoModel.close
    FileUtils.rm_f dbpath
  end

  context "a model" do

    should "have a db connection" do
      assert_not_nil Post.db
    end

    should "be gettable" do
      post2 = Post.get(@post.id)
      assert_equal @post.title, post2.title
      assert_equal 1, TokyoModel::DATABASES.first.rnum
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