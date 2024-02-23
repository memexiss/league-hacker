class Admin::GolfCourseHolesController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin
  
  def edit
    @course_holes = GolfCourse::Hole.find(params[:id])
  end

  def update
    @course_holes = GolfCourse::Hole.find(params[:id])
  
    if @course_holes.update(course_holes_params)
      redirect_to admin_golf_courses_path
    else
      render :edit
    end
  end  

  def new
    @course_holes = GolfCourse::Hole.new
    @courses = GolfCourse.all
  end

  def create
    @course_holes = GolfCourse::Hole.new(course_holes_params)
  
    if @course_holes.save
      redirect_to admin_golf_courses_path
    else
      redirect_to admin_golf_courses_path
    end
  end
  
	def destroy
    @course_holes = GolfCourse::Hole.find(params[:id])
		@course_holes.destroy

    redirect_to admin_golf_courses_path
  end

  private

  def course_holes_params
    params.require(:golf_course_hole).permit(:hole, :par, :handicap, :golf_course_id)
  end
end
