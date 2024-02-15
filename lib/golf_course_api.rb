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
