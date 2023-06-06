namespace :repo_analyzer  do
  desc "Extract repo info and post to defined endpoint"
  task :analyze, [:repo_name, :project_path] => :environment do |_t, args|
    project_info = RepoAnalyzer::ExtractProjectInfoJob.perform_now(
      args.repo_name, args.project_path
    )
    RepoAnalyzer::PostExtractedInfoJob.perform_now(args.repo_name, project_info)
  end
end
