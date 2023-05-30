module RepoAnalyzer
  class BundlerStatsExtractor < ProjectInfoExtractor
    private

    def extracted_info
      result = `bundle exec bundle-stats stats -f json`
      JSON.parse(result)
    end
  end
end
