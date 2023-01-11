module RepoAnalyzer
  class GithubExtractor < ProjectInfoExtractor
    private

    def extracted_info
      {
        last_commit_date: last_commit_date.to_s,
        last_contributors: last_contributors,
        contributors: contributors
      }
    end

    def last_contributors
      @last_contributors ||= contributors.select do |contributor|
        contributors_from_commits.include?(contributor[:login])
      end
    end

    def contributors_from_commits
      @contributors_from_commits ||= last_commits.inject([]) do |users, commit|
        if commit[:author]
          login = commit[:author][:login]
          users << login unless users.include?(login)
        end

        users
      end
    end

    def contributors
      @contributors ||= project_data_bridge.contributors.map do |contributor|
        build_user_info(contributor)
      end
    end

    def build_user_info(data)
      {
        login: data[:login],
        avatar_url: data[:avatar_url],
        contributions: data[:contributions]
      }
    end

    def last_commits
      @last_commits ||= begin
        return [] if last_commit_date == :not_found

        project_data_bridge.commits(
          from_date: last_commit_date - 2.months,
          to_date: last_commit_date + 1.day
        )
      end
    end

    def last_commit_date
      @last_commit_date ||= project_data_bridge.commits(
        from_date: Date.current - 2.years,
        to_date: Date.current
      ).first[:commit][:author][:date].to_date
    rescue NoMethodError
      :not_found
    end
  end
end
