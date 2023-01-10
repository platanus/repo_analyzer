require 'rails_helper'

describe RepoAnalyzer::RailsBestPracticesExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:error) do
      instance_double(
        "RailsBestPractices::Core::Error",
        filename: "spec/assets/test_project/app/controllers/team_controller.rb",
        line_number: "4",
        message: "move model logic into model (@team use_count > 4)",
        type: "RailsBestPractices::Reviews::MoveModelLogicIntoModelReview",
        url: "https://rails-bestpractices.com/posts/2010/07/21/move-model-logic-into-the-model/"
      )
    end

    let(:errors) do
      [
        error
      ]
    end

    let(:analyzer) do
      instance_double(
        "RailsBestPractices::Analyzer",
        analyze: true,
        errors: errors
      )
    end

    let(:expected) do
      {
        "file_path" => "app/controllers/team_controller.rb:4",
        "message" => "move model logic into model (@team use_count > 4)",
        "type" => "Reviews::MoveModelLogicIntoModelReview",
        "url" => "https://rails-bestpractices.com/posts/2010/07/21/move-model-logic-into-the-model/"
      }
    end

    before do
      allow(RailsBestPractices::Analyzer).to receive(:new).and_return(analyzer)
    end

    it { expect(extract[:rails_best_practices_extractor]["errors"].first).to eq(expected) }

    context "without errors" do
      let(:errors) do
        []
      end

      it { expect(extract[:rails_best_practices_extractor]["errors"].count).to eq(0) }
    end
  end
end
