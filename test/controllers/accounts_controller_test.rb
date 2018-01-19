require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should show new account form" do
    get new_account_url

    assert_response :success
    assert_equal "new", @controller.action_name
  end

  test "should redirect home if account created" do
    post account_url, params: { account: { name: "Sample Account", subdomain: "sample", owner_attributes: { first_name: "John", last_name: "Smith", email: "johnsmith@example.com", password: "12345678abc", password_confirmation: "12345678abc" } } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
