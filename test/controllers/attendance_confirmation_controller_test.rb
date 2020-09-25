require 'test_helper'

class AttendanceConfirmationControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get attendance_confirmation_create_url
    assert_response :success
  end

end
