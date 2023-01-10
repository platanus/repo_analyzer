require 'rails_helper'

describe RepoAnalyzer::RubocopExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:rubocop_result_content) do
      {
        "files" => [
          {
            "path" => "file1.rb",
            "offenses" => [
              {
                "cop_name" => "Lint/UnderscorePrefixedVariableName",
                "message" => "m1",
                "severity" => "warning",
                "location" => {
                  "line" => 78,
                  "column" => 33
                }
              },
              {
                "cop_name" => "Lint/UnderscorePrefixedVariableName",
                "message" => "m2",
                "severity" => "warning",
                "location" => {
                  "line" => 22,
                  "column" => 1
                }
              }
            ]
          },
          {
            "path" => "file2.rb",
            "offenses" => [
              {
                "cop_name" => "Lint/UnderscorePrefixedVariableName",
                "message" => "m3",
                "severity" => "warning",
                "location" => {
                  "line" => 60,
                  "column" => 2
                }
              }
            ]
          },
          {
            "path" => "file3.rb",
            "offenses" => [
              {
                "cop_name" => "Style/FrozenStringLiteralComment",
                "message" => "Style/FrozenStringLiteralComment: m4",
                "severity" => "convention",
                "location" => {
                  "line" => 66,
                  "column" => 4
                }
              }
            ]
          }
        ]
      }.to_json
    end

    let(:runner) do
      instance_double(
        "RuboCop::Runner",
        run: rubocop_result_content
      )
    end

    let(:expected) do
      {
        "convention" => {
          "Style/FrozenStringLiteralComment" => [
            {
              "message" => "m4",
              "path" => "file3.rb:66:4"
            }
          ]
        },
        "warning" => {
          "Lint/UnderscorePrefixedVariableName" => [
            {
              "message" => "m1",
              "path" => "file1.rb:78:33"
            },
            {
              "message" => "m2",
              "path" => "file1.rb:22:1"
            }, {
              "message" => "m3",
              "path" => "file2.rb:60:2"
            }
          ]
        }
      }
    end

    before do
      allow(RuboCop::Runner).to receive(:new).and_return(runner)
      allow(OutputUtils).to receive(:with_captured_stdout).and_return(rubocop_result_content)
    end

    it { expect(extract[:rubocop_extractor]["offenses"]).to eq(expected) }

    context "with rubocop errors" do
      before do
        allow(RuboCop::Runner).to receive(:new).and_raise(RuboCop::Error)
      end

      it { expect(extract[:rubocop_extractor]["offenses"]).to eq({}) }
    end
  end
end
