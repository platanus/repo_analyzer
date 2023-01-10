require 'rails_helper'

describe RepoAnalyzer::ProjectVersionsExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:expected) do
      {
        "circleci_version" => nil,
        "eslint_version" => nil,
        "node_version" => nil,
        "paperclip_version" => nil,
        "rails_version" => nil,
        "rubocop_version" => nil,
        "shrine_version" => nil,
        "sidekiq_version" => nil,
        "stylelint_version" => nil,
        "tailwind_version" => nil,
        "typescript_version" => nil,
        "vue_router_version" => nil,
        "vue_version" => nil
      }
    end

    it { expect(extract).to eq(project_versions_extractor: expected) }

    context "with valid files" do
      let(:expected) do
        {
          "circleci_version" => "2",
          "eslint_version" => "7.29.0",
          "node_version" => "12",
          "paperclip_version" => "5.0.0",
          "rails_version" => "6.0.4",
          "rubocop_version" => "1.18.0",
          "shrine_version" => "3.4.0",
          "sidekiq_version" => "6.2.2",
          "stylelint_version" => "13.13.1",
          "tailwind_version" => "2",
          "typescript_version" => "4.5.5",
          "vue_router_version" => "3.0.7",
          "vue_version" => "2.6.14"
        }
      end

      before do
        mock_file_content("package.json", "valid_package_json")
        mock_file_content("Gemfile.lock", "valid_gemfile_lock")
        mock_file_content(".circleci/config.yml", "valid_circleci_config.yml")
      end

      it { expect(extract).to eq(project_versions_extractor: expected) }
    end

    context "with invalid files" do
      before do
        mock_file_content("package.json", "valid_gem_gemfile_lock")
        mock_file_content("Gemfile.lock", "valid_gem_gemfile_lock")
        mock_file_content(".circleci/config.yml", "valid_gem_gemfile_lock")
      end

      it { expect(extract).to eq(project_versions_extractor: expected) }
    end
  end
end
