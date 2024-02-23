class Admin::GolfCoursesController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin

  def index
    @courses = GolfCourse.all
    @course_holes = GolfCourse::Hole.all
    @tees = GolfCourse::Hole::Tee.all
  end

  def search
    response = GolfCourseApi.new.search(params[:course])
    @courses = process_response(response)
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

  def process_response(response)
    return if response.is_a?(Hash) && response.dig('message') == 'No courses found' 

    response.map do |course_data| 
      remote_data = map_api_data(course_data)
      course = GolfCourse.find_or_initialize_by remote_api_id: remote_data[:remote_api_id]
      course.update(remote_data) if course.new_record?
      course
    end
  end
  
  def map_api_data(course_data)
    coordinates = course_data['coordinates']
    course_attributes = {
      remote_api_id: course_data['_id'],
      remote_api_version: course_data['__v'],
      address: course_data['address'],
      city: course_data['city'],
      latitude: coordinates.present? ? coordinates.split(',').first&.gsub('(', '').strip : nil,
      longitude: coordinates.present? ? coordinates.split(',').last&.gsub(')', '').strip : nil,           
      country: course_data['country'],
      fairway_grass: course_data['fairwayGrass'],
      green_grass: course_data['greenGrass'],
      number_of_holes: course_data['holes'],
      length_format: course_data['lengthFormat'],
      name: course_data['name'],
      phone: course_data['phone'],
      state: course_data['state'],
      website: course_data['website'],
      zip: course_data['zip']
    }
    if course_data.dig("scorecard").present? 
      holes_attributes = course_data.dig("scorecard").map do |data| 
        hole_attributes = {hole: data["Hole"], par: data["Par"], handicap: data["Handicap"]}
        if data["tees"].present? 
          tees_attributes = data["tees"].map do |tee_data| 
            name, t_data = tee_data
            {name: name, color: t_data["color"], yards: t_data["yards"]}
          end
          hole_attributes[:tees_attributes] = tees_attributes
        end
        hole_attributes
      end
      course_attributes[:holes_attributes] = holes_attributes
    end
    course_attributes
    if course_data.dig("teeBoxes").present? 
      tee_box_attributes = course_data.dig("teeBoxes").map do |data| 
        tee_box_attributes = {tee: data["tee"], slope: data["slope"], handicap: data["handicap"]}
        tee_box_attributes
      end
      course_attributes[:tee_boxes_attributes] = tee_box_attributes
    end
    course_attributes
    
  end
  
end
