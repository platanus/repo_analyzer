require 'rails_helper'

describe RepoAnalyzer::BrakemanExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:file) do
      instance_double(
        "Brakeman::FilePath",
        relative: "app/controllers/api/base_controller.rb"
      )
    end

    let(:warning) do
      instance_double(
        "Brakeman::Warning",
        warning_type: "Basic Auth",
        check: "Brakeman::CheckBasicAuth",
        message: "Basic authentication password stored in source code",
        file: file,
        link: "https://bla.com",
        line: 14,
        confidence: 0,
        format_code: "where(bla: 1)"
      )
    end

    let(:warnings) do
      [
        warning
      ]
    end

    let(:checks) do
      instance_double(
        "Brakeman::Checks",
        warnings: warnings
      )
    end

    let(:tracker) do
      instance_double(
        "Brakeman::Tracker",
        checks: checks
      )
    end

    let(:expected) do
      {
        "warning_type" => "Basic Auth",
        "check" => "Brakeman::CheckBasicAuth",
        "message" => "Basic authentication password stored in source code",
        "file_path" => "app/controllers/api/base_controller.rb",
        "link" => "https://bla.com",
        "line" => 14,
        "confidence" => "High",
        "code" => "where(bla: 1)"
      }
    end

    before do
      allow(Brakeman).to receive(:run).and_return(tracker)
    end

    it { expect(extract[:brakeman_extractor]["warnings"].first).to eq(expected) }

    context "without warnings" do
      let(:warnings) do
        []
      end

      it { expect(extract[:brakeman_extractor]["warnings"].count).to eq(0) }
    end
  end
end
