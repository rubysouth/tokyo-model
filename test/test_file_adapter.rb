require File.dirname(__FILE__) + '/test_helper'

class TestFileAdapter < Test::Unit::TestCase

  test "default open mode should be read/write" do
    assert_equal 3, TokyoModel::Adapters::File.default_open_mode
  end

end
