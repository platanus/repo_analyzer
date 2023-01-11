require 'rails_helper'

describe RepoAnalyzer::PowerTypesExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:expected) do
      {
        "clients" => false,
        "commands" => true,
        "observers" => true,
        "services" => false,
        "utils" => false,
        "values" => false
      }
    end

    it { expect(extract).to eq(power_types_extractor: expected) }
  end
end
