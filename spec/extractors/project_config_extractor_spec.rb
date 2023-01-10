require 'rails_helper'

describe RepoAnalyzer::ProjectConfigExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:expected) do
      {
        "simplecov" => false,
        "makefile_commands" => [],
        "rubocop_rules" => []
      }
    end

    it { expect(extract).to eq(project_config_extractor: expected) }

    context "with existent config files" do
      let(:expected) do
        {
          "simplecov" => true,
          "makefile_commands" => [
            "backup-production",
            "backup-staging",
            "restore-from-production",
            "restore-from-staging",
            "services-port"
          ],
          "rubocop_rules" => [
            "AllCops",
            "Layout/ParameterAlignment",
            "Lint/StructNewOverride",
            "Metrics/BlockLength",
            "Performance",
            "Performance/RedundantBlockCall",
            "RSpec/MultipleExpectations",
            "Rails",
            "Rails/Delegate",
            "Style/ClassAndModuleChildren",
            "Style/FormatString",
            "Style/FrozenStringLiteralComment"
          ]
        }
      end

      before do
        mock_file_content("Makefile", "valid_makefile")
        mock_file_content(".rubocop.yml", "valid_rubocop_rules.yml")
        mock_file_existance("spec/simplecov_config.rb")
      end

      it { expect(extract).to eq(project_config_extractor: expected) }
    end
  end
end
