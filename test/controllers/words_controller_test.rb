require 'test_helper'

class WordsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get words_list_url
    assert_response :success
  end

end
