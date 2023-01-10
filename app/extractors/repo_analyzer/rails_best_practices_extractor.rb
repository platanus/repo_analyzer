module RepoAnalyzer
  class RailsBestPracticesExtractor < ProjectInfoExtractor
    private

    def extracted_info
      analyzer.analyze
      { errors: errors }
    end

    def errors
      @errors ||= analyzer.errors.map do |error|
        next unless error.filename.include?(project_data_bridge.tmp_repo_path)

        {
          file_path: get_file_path(error),
          message: error.message,
          type: error.type.gsub("RailsBestPractices::", ""),
          url: error.url
        }
      end.compact
    end

    def get_file_path(error)
      [
        error.filename.gsub(%r{\A\D*#{project_data_bridge.tmp_repo_path}/}, ""),
        error.line_number
      ].reject(&:blank?).join(":")
    end

    def analyzer
      @analyzer ||= RailsBestPractices::Analyzer.new(
        project_data_bridge.tmp_repo_path
      )
    end
  end
end
