require 'rails_helper'

describe RepoAnalyzer::ExtractProjectInfoJob, type: :job do
  let(:repo_name) { "platanus/alisur-formulator" }

  let(:files_list) do
    "app/extractors/repo_analyzer/project_versions_extractor.rb"
  end

  let(:bridge) do
    instance_double(
      "RepoAnalyzer::ProjectDataBridge"
    )
  end

  let(:extracted_data) do
    {
      project_versions_extractor: {
        rails_version: "6.0"
      }
    }
  end

  let(:extractor) do
    instance_double(
      "RepoAnalyzer::ProjectVersionsExtractor",
      extract: extracted_data
    )
  end

  let(:engine_root) { instance_double("Pathname", join: files_list) }

  def perform_now
    described_class.perform_now(repo_name)
  end

  before do
    allow(RepoAnalyzer::Engine).to receive(:root).and_return(engine_root)
    allow(RepoAnalyzer::ProjectDataBridge).to receive(:new).and_return(bridge)
    allow(RepoAnalyzer::ProjectVersionsExtractor).to receive(:new).and_return(extractor)
  end

  it { expect(perform_now).to eq(extracted_data) }

  it do
    perform_now
    expect(RepoAnalyzer::ProjectDataBridge).to have_received(:new).with(repo_name).once
    expect(RepoAnalyzer::ProjectVersionsExtractor).to have_received(:new).with(bridge).once
  end
end
