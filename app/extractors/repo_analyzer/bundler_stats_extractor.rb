module RepoAnalyzer
  class BundlerStatsExtractor < ProjectInfoExtractor
    private

    def extracted_info
      stats['gems'] = gems_info
      stats
    end

    def gems_info
      gem_names.inject([]) do |memo, gem_name|
        result = `bundle exec bundle-stats show '#{gem_name}' -f json`
        memo << JSON.parse(result)
        memo
      end
    end

    def gem_names
      stats['gems'].map { |gem| gem['name'] }
    end

    def stats
      @stats ||= JSON.parse(`bundle exec bundle-stats stats -f json`)
    end
  end
end
