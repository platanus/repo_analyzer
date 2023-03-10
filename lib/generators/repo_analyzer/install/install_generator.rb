class RepoAnalyzer::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_initializer
    template "initializer.rb", "config/initializers/repo_analyzer.rb"
  end

  def mount_routes
    line = "Rails.application.routes.draw do\n"
    inject_into_file "config/routes.rb", after: line do <<-"HERE".gsub(/^ {4}/, '')
      mount RepoAnalyzer::Engine => "/repo_analyzer"
    HERE
    end
  end

  def copy_engine_migrations
    rake "railties:install:migrations"
  end
end
