require 'test_helper'

class ClickLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get click_logs_create_url
    assert_response :success
  end

end
