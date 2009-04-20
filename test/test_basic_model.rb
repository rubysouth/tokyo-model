require 'test_helper'

class TestBasicModel < Test::Unit::TestCase

  setup do
    load_fixtures
  end

  context "a model" do

    should "have a db connection" do
      assert Post.db.respond_to?(:get)
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