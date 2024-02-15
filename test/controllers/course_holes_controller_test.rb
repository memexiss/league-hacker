require "test_helper"

class CourseHolesControllerTest < ActionDispatch::IntegrationTest
  test "should get controller" do
    get course_holes_controller_url
    assert_response :success
  end
end
