require 'test_helper'

class UserReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_reviews_create_url
    assert_response :success
  end

end
