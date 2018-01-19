require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test 'should redirect to sign in if user is not signed in' do
    get subdomain_root_url(subdomain: 'subdomain')

    assert_response :redirect
    assert_redirected_to new_user_session_url(subdomain: 'subdomain')
  end
end
