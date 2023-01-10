Rails.application.routes.draw do
  mount RepoAnalyzer::Engine => "/repo_analyzer"
end
