require "bundler/audit"
require "brakeman"
require "fasterer"
require "octokit"
require "rails_best_practices"
require "reek"
require "rubocop"
require "rubocop-performance"
require "rubocop-platanus"
require "rubocop-rails"
require "rubocop-rspec"

require "repo_analyzer/engine"

module RepoAnalyzer
  extend self

  # You can add, in this module, your own configuration options as in the example below...
  #
  # attr_writer :my_option
  #
  # def my_option
  #   return "Default Value" unless @my_option
  #   @my_option
  # end
  #
  # Then, you can customize the default behaviour (typically in a Rails initializer) like this:
  #
  # RepoAnalyzer.setup do |config|
  #   config.root_url = "Another value"
  # end

  attr_writer :github_personal_token, :post_extracted_info_endpoint

  def github_personal_token
    return ENV["GITHUB_PERSONAL_TOKEN"] if @github_personal_token.blank?

    @github_personal_token
  end

  def post_extracted_info_endpoint
    return ENV["REPO_ANALYZER_URL"] if @post_extracted_info_endpoint.blank?

    @post_extracted_info_endpoint
  end

  def setup
    yield self
    require "repo_analyzer"
  end
end
