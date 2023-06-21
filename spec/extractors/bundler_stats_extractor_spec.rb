require 'rails_helper'

describe RepoAnalyzer::BundlerStatsExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:rspec_junit_formatter) do
      {
        "name": "rspec_junit_formatter",
        "total_dependencies": 2,
        "first_level_dependencies": 1,
        "top_level_dependencies": {},
        "transitive_dependencies": [
          "rspec-core (>= 2, < 4, != 2.12.0)",
          "rspec-support (~> 3.12.0)"
        ]
      }
    end

    let(:sqlite) do
      {
        "name": "sqlite",
        "total_dependencies": 0,
        "first_level_dependencies": 0,
        "top_level_dependencies": {},
        "transitive_dependencies": []
      }
    end

    let(:stats) do
      {
        "summary": {
          "declared": 10,
          "unpinned": 9,
          "total": 117,
          "github": 0
        },
        "gems": [
          rspec_junit_formatter,
          sqlite
        ]
      }
    end

    before do
      allow(extractor).to receive(:`).with(
        'bundle exec bundle-stats stats -f json'
      ).and_return(stats.to_json)

      allow(extractor).to receive(:`).with(
        "bundle exec bundle-stats show 'rspec_junit_formatter' -f json"
      ).and_return(rspec_junit_formatter.to_json)

      allow(extractor).to receive(:`).with(
        "bundle exec bundle-stats show 'sqlite' -f json"
      ).and_return(sqlite.to_json)
    end

    it { expect(extract[:bundler_stats_extractor]).to eq(stats.with_indifferent_access) }
  end
end
