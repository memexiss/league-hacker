class Admin::GolfCoursesController < ApplicationController
  before_action :verify_sign_in
  before_action :verify_admin

  def index
    @courses = GolfCourse.all
    @course_holes = GolfCourse::Hole.all
    @tees = GolfCourse::Hole::Tee.all
  end

  def search
    course_name = params[:course]
    golf_course_api = GolfCourseApi.new
    @course = golf_course_api.search(course_name)
    @course_instance = GolfCourse.new(map_api_data(@course))
    if !@course_instance.name.nil?
      @course_instance.save
      render partial: 'result'
    else
      redirect_to admin_golf_courses_path
    end
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

  def map_api_data(api_data)
    if api_data.present? && api_data[0].present?
      coordinates = api_data[0]['coordinates']
      course_attributes = {
        remote_api_id: api_data[0]['_id'],
        remote_api_version: api_data[0]['__v'],
        address: api_data[0]['address'],
        city: api_data[0]['city'],
        latitude: coordinates.present? ? coordinates.split(',').first&.gsub('(', '').strip : nil,
        longitude: coordinates.present? ? coordinates.split(',').last&.gsub(')', '').strip : nil,           
        country: api_data[0]['country'],
        fairway_grass: api_data[0]['fairwayGrass'],
        green_grass: api_data[0]['greenGrass'],
        number_of_holes: api_data[0]['holes'],
        length_format: api_data[0]['lengthFormat'],
        name: api_data[0]['name'],
        phone: api_data[0]['phone'],
        state: api_data[0]['state'],
        website: api_data[0]['website'],
        zip: api_data[0]['zip']
      }
      if api_data[0].dig("scorecard").present? 
        holes_attributes = api_data[0].dig("scorecard").map do |data| 
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
      if api_data[0].dig("teeBoxes").present? 
        tee_box_attributes = api_data[0].dig("teeBoxes").map do |data| 
          tee_box_attributes = {tee: data["tee"], slope: data["slope"], handicap: data["handicap"]}
          tee_box_attributes
        end
        course_attributes[:tee_boxes_attributes] = tee_box_attributes
      end
      course_attributes
    else
      {
        remote_api_id: nil,
        address: nil,
        city: nil,
        latitude: nil,
        longitude: nil,
        country: nil,
        fairway_grass: nil,
        green_grass: nil,
        number_of_holes: nil,
        length_format: nil,
        name: nil,
        phone: nil,
        state: nil,
        website: nil,
        zip: nil
      }
    end
  end
  
end
