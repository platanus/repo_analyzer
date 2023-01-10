module RepoAnalyzer
  class BrakemanExtractor < ProjectInfoExtractor
    CONFIDENCE = {
      0 => "High",
      1 => "Medium",
      2 => "Weak"
    }

    private

    def extracted_info
      { warnings: brakeman_info }
    end

    def brakeman_info
      @brakeman_info ||= begin
        tracker = Brakeman.run(app_path: project_data_bridge.project_path)
        tracker.checks.warnings.map do |warning|
          {
            warning_type: warning.warning_type,
            check: warning.check,
            message: warning.message.to_s,
            file_path: warning.file.relative,
            link: warning.link,
            line: warning.line,
            confidence: CONFIDENCE[warning.confidence],
            code: warning.format_code
          }
        end
      end
    end
  end
end
