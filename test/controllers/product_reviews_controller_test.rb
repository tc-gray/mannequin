require 'test_helper'

class ProductReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get product_reviews_create_url
    assert_response :success
  end

end
