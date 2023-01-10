require "brakeman"
require "octokit"
require "rails_best_practices"
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

  def setup
    yield self
    require "repo_analyzer"
  end
end
