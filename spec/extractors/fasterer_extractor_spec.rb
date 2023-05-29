require 'rails_helper'

describe RepoAnalyzer::FastererExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:fasterer_result_content) do
      <<~TEXT
        \e[0;31;49mapp/extractors/repo_analyzer/github_extractor.rb:60\e[0m Don't rescue NoMethodError, rather check with respond_to?.

          \e[0;31;49mapp/jobs/repo_analyzer/extract_project_info_job.rb:17\e[0m Calling blocks with call is slower than yielding.

          \e[0;31;49mspec/dummy/config/puma.rb:14\e[0m Hash#fetch with second argument is slower than Hash#fetch with block.

          \e[0;32;49m75 files inspected\e[0m, \e[0;31;49m3 offenses detected\e[0m
      TEXT
    end

    before do
      allow(OutputUtils).to receive(:with_captured_stdout).and_return(fasterer_result_content)
    end

    let(:expected) do
      {
        speedups: [
          {
            file_path: "app/extractors/repo_analyzer/github_extractor.rb",
            line: "60",
            message: "Don't rescue NoMethodError, rather check with respond_to?."
          },
          {
            file_path: "app/jobs/repo_analyzer/extract_project_info_job.rb",
            line: "17",
            message: "Calling blocks with call is slower than yielding."
          },
          {
            file_path: "spec/dummy/config/puma.rb",
            line: "14",
            message: "Hash#fetch with second argument is slower than Hash#fetch with block."
          }
        ]
      }.with_indifferent_access
    end

    it { expect(extract[:fasterer_extractor]).to eq(expected) }
  end
end
