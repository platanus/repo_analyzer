require 'rails_helper'

describe RepoAnalyzer::GithubExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:commits) do
      [
        {
          commit: {
            author: {
              date: "1984-04-06"
            }
          },
          author: {
            login: "lean"
          }
        },
        {
          commit: {
            author: {
              date: "1983-03-02"
            }
          },
          author: {
            login: "lean"
          }
        },
        {
          commit: {
            author: {
              date: "1982-03-01"
            }
          },
          author: {
            login: "santi"
          }
        }
      ]
    end

    let(:contributors) do
      [
        {
          login: "lean",
          avatar_url: "http://lean@github.com",
          contributions: 200
        },
        {
          login: "matias",
          avatar_url: "http://mati@github.com",
          contributions: 100
        },
        {
          login: "santi",
          avatar_url: "http://santi@github.com",
          contributions: 700
        }
      ]
    end

    before do
      allow(project_data_bridge).to receive(:commits).and_return(commits)
      allow(project_data_bridge).to receive(:contributors).and_return(contributors)
    end

    def last_contributors_logins
      extract[:github_extractor][:last_contributors].map { |contributor| contributor[:login] }
    end

    def contributors_logins
      extract[:github_extractor][:contributors].map { |contributor| contributor[:login] }
    end

    it { expect(extract[:github_extractor][:last_commit_date]).to eq("1984-04-06") }
    it { expect(contributors_logins).to contain_exactly("lean", "matias", "santi") }
    it { expect(last_contributors_logins).to contain_exactly("lean", "santi") }
  end
end
