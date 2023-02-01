# frozen_string_literal: true

module RepoAnalyzerExtractorHelpers
  extend ActiveSupport::Concern

  included do
    let(:extractor) { described_class.new(project_data_bridge) }
    let(:repo_name) { "test_project" }
    let(:project_data_bridge) { RepoAnalyzer::ProjectDataBridge.new(repo_name) }
    let(:project_path) { "spec/assets/test_project" }
    let(:github_client) { instance_double("RepoAnalyzer::GithubClient") }

    def extract
      extractor.extract
    end

    def mock_file_content(file_path, fake_file_path)
      fake_file_content = File.open("#{project_path}/#{fake_file_path}").read
      allow(project_data_bridge).to receive(:file_content)
        .with(file_path).and_return(fake_file_content)
    end

    def mock_file_existance(file_path)
      allow(project_data_bridge).to receive(:file_exist?)
        .with(file_path).and_return(true)
    end

    before do
      allow(project_data_bridge).to receive(:project_path).and_return(project_path)
      allow(RepoAnalyzer::GithubClient).to receive(:new).and_return(github_client)
    end
  end
end

RSpec.configure do |config|
  config.include RepoAnalyzerExtractorHelpers, repo_analyzer_extractor_helpers: true
end
