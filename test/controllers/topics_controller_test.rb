require 'test_helper'

class TopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_topic_url
    assert_response :success
  end

end
