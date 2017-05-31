require 'test_helper'

class BraintreeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get braintree_new_url
    assert_response :success
  end

end
