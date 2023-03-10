require 'rails_helper'

describe RepoAnalyzer::TestsInfoExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:expected) do
      {
        "swagger_tests_count" => 1,
        "system_tests_count" => 1,
        "jest_tests_count" => 2,
        "rails_code_coverage" => {
          "controllers" => {
            "files_count" => 0,
            "tests_count" => 0
          },
          "mailers" => {
            "files_count" => 0,
            "tests_count" => 0
          },
          "models" => {
            "files_count" => 0,
            "tests_count" => 0
          },
          "jobs" => {
            "files_count" => 0,
            "tests_count" => 0
          },
          "policies" => {
            "files_count" => 0,
            "tests_count" => 0
          },
          "commands" => {
            "files_count" => 1,
            "tests_count" => 2
          },
          "services" => {
            "files_count" => 0,
            "tests_count" => 0
          },
          "observers" => {
            "files_count" => 1,
            "tests_count" => 0
          },
          "values" => {
            "files_count" => 0,
            "tests_count" => 0
          },
          "utils" => {
            "files_count" => 0,
            "tests_count" => 0
          },
          "clients" => {
            "files_count" => 0,
            "tests_count" => 0
          },
          "total" => {
            "files_count" => 2,
            "tests_count" => 2
          }
        },
        "simplecov_coverage" => {
          "controllers" => 100.0,
          "clients" => nil,
          "mailers" => 57.14,
          "models" => 97.22,
          "jobs" => 80.23,
          "policies" => 0.0,
          "commands" => 100.0,
          "services" => 100.0,
          "observers" => 100.0,
          "utils" => 77.78,
          "values" => nil,
          "total" => 79.15
        }
      }
    end

    it { expect(extract).to eq(tests_info_extractor: expected) }
  end
end
