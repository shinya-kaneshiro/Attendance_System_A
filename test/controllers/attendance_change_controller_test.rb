require 'test_helper'

class AttendanceChangeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get attendance_change_create_url
    assert_response :success
  end

end
