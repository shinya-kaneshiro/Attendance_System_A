require 'test_helper'

class AttendanceOvertimeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get attendance_overtime_create_url
    assert_response :success
  end

end
