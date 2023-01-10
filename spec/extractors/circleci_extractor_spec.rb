require 'rails_helper'

describe RepoAnalyzer::CircleciExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:expected) do
      {
        "code_coverage" => true,
        "jest" => true,
        "rspec" => true,
        "system_tests" => true,
        "eslint" => true,
        "rubocop" => true,
        "stylelint" => true,
        "platanus_compose" => false
      }
    end

    before do
      mock_file_content(".circleci/config.yml", "valid_circleci_config.yml")
    end

    it { expect(extract).to eq(circleci_extractor: expected) }

    context "with old config" do
      let(:expected) do
        {
          "code_coverage" => false,
          "jest" => true,
          "rspec" => true,
          "system_tests" => false,
          "eslint" => false,
          "rubocop" => false,
          "stylelint" => false,
          "platanus_compose" => true
        }
      end

      before do
        mock_file_content(".circleci/config.yml", "old_circleci_config.yml")
      end

      it { expect(extract).to eq(circleci_extractor: expected) }
    end
  end
end
