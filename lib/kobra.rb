#require "kobra/version"
require "rest_client"
require "json/ext"

module Kobra
  class Client
    
    class BadResponse < RuntimeError; end
    class NotFound < RuntimeError; end
    class AuthError < RuntimeError; end
    class ServerError < RuntimeError; end

    #Kobra::Client.new(:domain => "kobra.karservice.se", :api_key => "12345abcde")
    def initialize(settings = {})
      settings[:domain] ||= 'kobra.karservice.se'
      @api_key ||= settings[:api_key]
      @base_url = "https://#{settings[:domain]}/"
    end

    
    # get_student(:id => "(studentID)", :union => true, :section => true)
    # Parameters: 
    #  :id              - can be liu_id, mifare-number, or norEduPersonLIN
    #  :union => true   - to get the union name
    #  :section => true - to get the section name
    def get_student(parameters)
      student = json_get("api/v1/students/#{parameters[:id]}")

      #if union == true as parameter get the union name
      if (parameters[:union]) 
        student = get_union(student)
      end

      # if section == true as parameter get the section name
      if (parameters[:section])
        student = get_section(student)
      end

      return student
    end

    private

    # Helper function to get the union name
    def get_union(student)
      unless student[:union].nil?
        union_id = student[:union].split('/').last
        student[:union] = json_get("api/v1/unions/#{union_id}")[:name]
      end

      return student
    end

    # Helper function to get the section name
    def get_section(student)
      unless student[:section].nil?
        section_id = student[:section].split('/').last
        student[:section] = json_get("api/v1/sections/#{section_id}")[:name]
      end

      return student
    end


    # GETs to the path with the api_key, returns JSON with symbols
    def json_get(path)
      url = @base_url + path

      response = RestClient.get url, {:authorization => "Token #{@api_key}"}

      JSON.parse(response.body, :symbolize_names => true)

      rescue JSON::ParserError
        raise BadResponse, "Can't parse JSON"
      rescue RestClient::ResourceNotFound
        raise NotFound, "Resource not found"
      rescue RestClient::Unauthorized
        raise AuthError, "Authentication failed"
      rescue RestClient::InternalServerError
        raise ServerError, "Server error"
    end
  end
end
