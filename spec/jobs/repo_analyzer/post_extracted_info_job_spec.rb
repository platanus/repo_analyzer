require 'rails_helper'

describe RepoAnalyzer::PostExtractedInfoJob, type: :job do
  let(:project_info) do
    {
      "extracted" => "info"
    }
  end

  let(:condition_result) { double }

  let(:response) do
    instance_double(
      "Net::HTTPCreated",
      is_a?: condition_result
    )
  end

  let(:repo_name) { "hay-gas" }

  let(:expected_post_data) do
    {
      repo_name: repo_name,
      project_info: "eJyrVkqtKClKTC5JTVGyUsrMS8tXqgUATWwHKw==\n"
    }.to_json
  end

  def perform_now
    described_class.perform_now(repo_name, project_info)
  end

  before do
    allow(Net::HTTP).to receive(:post).and_return(response)
  end

  it do
    expect(perform_now).to eq(condition_result)
    expect(Net::HTTP).to have_received(:post).with(
      URI("http://localhost:3000/api/v1/repo_analyzer/project_info"),
      expected_post_data,
      "Content-Type" => "application/json"
    ).once
    expect(response).to have_received(:is_a?).with(Net::HTTPCreated).once
  end
end
