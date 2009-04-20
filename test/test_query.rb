require 'test_helper'

class TestQuery < Test::Unit::TestCase
  
  def setup
    load_fixtures
  end
  
  def test_a_query
    @posts = Post.find do
      title_has "First"
      author_is "John Doe"
      body_matches "[a-zA-Z,\.\s]*$"
    end
    p @posts
  end

end