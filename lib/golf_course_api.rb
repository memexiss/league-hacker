require 'uri'
require 'net/http'
class GolfCourseApi
  attr_reader :course_name

  def search(course_name)
    @course_name = course_name
    response = http.request(request_api)
    if response.code == '200'
      result = JSON.parse(response.read_body) 
      result
    else 
      puts "API request failed with response code: #{response.code}"
    end
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
  private

  def http 
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http
  end
  def request_api 
    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = Rails.application.credentials.dig(:api, :golf_course_api, :key)
    request["X-RapidAPI-Host"] = 'golf-course-api.p.rapidapi.com'
    request
  end
  def url
    uri = URI("https://golf-course-api.p.rapidapi.com/search")
    uri.query = URI.encode_www_form({name: course_name})
    uri
  end

end
