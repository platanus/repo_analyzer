require 'zlib'
require 'base64'
require 'net/http'
require 'uri'

module RepoAnalyzer
  class PostExtractedInfoJob < ApplicationJob
    def perform(repo_name, project_info)
      encoded_project_info = encode_project_info(project_info)
      response = post_project_info(repo_name, encoded_project_info)
      response.is_a?(Net::HTTPCreated)
    end

    private

    def post_project_info(repo_name, encoded_project_info)
      uri = URI(RepoAnalyzer.post_extracted_info_endpoint)
      data = { repo_name: repo_name, project_info: encoded_project_info }.to_json
      headers = { "Content-Type" => "application/json" }
      Net::HTTP.post(uri, data, headers)
    end

    def encode_project_info(project_info)
      compressed_data = Zlib::Deflate.deflate(project_info.to_json)
      Base64.encode64(compressed_data)
    end
  end
end
