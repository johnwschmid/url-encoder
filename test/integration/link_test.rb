require "test_helper"

class LinkTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "create link requires url" do
    post links_path, params: { link: { url: ''}}
    assert_response :unprocessable_entity
  end
  test "create link as guest" do
    assert_difference "Link.count" do 
      post links_path(format: :turbo_stream), params: { link: { url: 'https://testing.com'}}
      assert_response :ok
      assert_nil Link.last.user_id
    end
  end
  test "create link as user" do
    user = users(:one)
    sign_in user
    assert_difference "Link.count" do 
      post links_path, params: { link: { url: 'https://testing.com'}}
      assert_response :redirect
      assert_equal user.id, Link.last.user_id
    end
  end
  test "can edit anonymous link as guest" do
    get edit_link_path(links(:anonymous))
    assert_response :ok
  end
  test "cannot edit user-created link as guest" do
    get edit_link_path(links(:one))
    assert_response :redirect
  end
  test "cannot edit user-created link as diff user" do
    user = users(:two)
    sign_in user
    get edit_link_path(links(:one))
    assert_response :redirect
  end
end
