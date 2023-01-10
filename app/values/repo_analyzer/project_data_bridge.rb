module RepoAnalyzer
  class ProjectDataBridge
    EXCLUDED_FILE_NAMES = %w{. .. .keep .gitkeep}

    def initialize(repo_name)
      @repo_name = repo_name
    end

    def tmp_repo_path
      "tmp/#{repo_name}"
    end

    def file_exist?(file_path)
      File.exist?("#{tmp_repo_path}/#{file_path}")
    end

    def file_content(file_path)
      return unless file_exist?(file_path)

      File.open("#{tmp_repo_path}/#{file_path}").read
    end

    def dir_files(dir_path)
      Dir.glob("#{tmp_repo_path}/#{dir_path}/**/*").reject do |file_name|
        EXCLUDED_FILE_NAMES.include?(file_name)
      end
    rescue Errno::ENOENT
      []
    end

    def commits(options = {})
      github_client.commits(repo_name, options)
    end

    def contributors
      github_client.contributors(repo_name)
    end

    private

    attr_reader :repo_name

    def github_client
      @github_client ||= GithubClient.new(ENV["GITHUB_PERSONAL_TOKEN"])
    end
  end
end
