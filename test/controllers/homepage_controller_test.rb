require "test_helper"

class HomepageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_redirected_to '/hacker/login'
  end
end
