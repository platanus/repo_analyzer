require 'rails_helper'

describe RepoAnalyzer::ReekExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:reek_result_content) do
      [
        {
          "context" => "ApplicationCable::Channel",
          "lines" => [2],
          "message" => "has no descriptive comment",
          "smell_type" => "IrresponsibleModule",
          "source" => "spec/assets/test_project/app/channels/application_cable/channel.rb",
          "documentation_link" => "http://gh.com/reek/blob/v6.1.4/docs/Irresponsible-Module.md"
        },
        {
          "context" => "ApplicationCable::Connection",
          "lines" => [2],
          "message" => "has no descriptive comment",
          "smell_type" => "IrresponsibleModule",
          "source" => "spec/assets/test_project/app/channels/application_cable/connection.rb",
          "documentation_link" => "http://gh.com/reek/blob/v6.1.4/docs/Irresponsible-Module.md"
        },
        {
          "context" => "AbastibleClient#parse_prices_by_type",
          "lines" => [189],
          "message" => "has the variable name 'e'",
          "smell_type" => "UncommunicativeVariableName",
          "source" => "spec/assets/test_project/app/clients/abastible_client.rb",
          "name" => "e",
          "documentation_link" => "http://gh.com/reek/blob/v6.1.4/docs/Uncommunicative-Variable-Name.md"
        }
      ].to_json
    end

    before do
      allow(OutputUtils).to receive(:with_captured_stdout).and_return(reek_result_content)
    end

    let(:expected) do
      {
        "warnings" =>
          {
            "IrresponsibleModule" =>
              [
                {
                  "lines" => [2],
                  "message" => "has no descriptive comment",
                  "source" => "app/channels/application_cable/channel.rb",
                  "name" => nil,
                  "documentation_link" => "http://gh.com/reek/blob/v6.1.4/docs/Irresponsible-Module.md"
                },
                {
                  "lines" => [2],
                  "message" => "has no descriptive comment",
                  "source" => "app/channels/application_cable/connection.rb",
                  "name" => nil,
                  "documentation_link" => "http://gh.com/reek/blob/v6.1.4/docs/Irresponsible-Module.md"
                }
              ],
            "UncommunicativeVariableName" =>
              [
                {
                  "lines" => [189],
                  "message" => "has the variable name 'e'",
                  "source" => "app/clients/abastible_client.rb",
                  "name" => "e",
                  "documentation_link" => "http://gh.com/reek/blob/v6.1.4/docs/Uncommunicative-Variable-Name.md"
                }
              ]
          }
      }
    end

    it { expect(extract[:reek_extractor]).to eq(expected) }
  end
end
