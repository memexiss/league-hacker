class Admin::GolfCoursesController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin

  def index
    @courses = GolfCourse.all
    @course_holes = GolfCourse::Hole.all
    @tees = GolfCourse::Hole::Tee.all
  end

  def search
    golf_course_api = GolfCourseApi.new
    response = golf_course_api.search(params[:course])
    @courses = golf_course_api.process_response(response)
    if @courses
      render partial: 'result'
    else 
      redirect_to admin_golf_courses_path, alert: "No courses found for #{params[:course]}"
    end
  end  

  def show 
    @course = GolfCourse.find(params[:id])
  end

  def edit
    @course = GolfCourse.find(params[:id])
  end

  def update
    @course = GolfCourse.find(params[:id])
  
    if @course.update(course_params)
      redirect_to admin_golf_courses_path
    else
      render :edit
    end
  end  

  def new
    @course = GolfCourse.new
  end

  def create
    @course = GolfCourse.new(course_params)
  
    if @course.save
      create_course_holes(@course, params[:golf_course]['holes_attributes'])
      redirect_to admin_golf_courses_path
    else
      redirect_to admin_golf_courses_path
    end
  end
  
	def destroy
    @course = GolfCourse.find(params[:id])
		@course.destroy

    redirect_to admin_golf_courses_path
  end

  private

  def course_params
    params.require(:golf_course).permit(
      :name, :address, :city, :latitude, :longitude, :country, :fairway_grass, :green_grass,
      :number_of_holes, :length_format, :phone, :state, :website, :zip, :remote_api_version, 
      :remote_api_id, holes_attributes: [:hole, :par, :handicap, tees_attributes: [:name, :color, :yards]],
      tee_boxes_attributes: [:tee, :slope, :handicap]
    )
  end
  
end
