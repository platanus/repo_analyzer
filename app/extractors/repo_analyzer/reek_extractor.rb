require "reek/cli/application"

module RepoAnalyzer
  class ReekExtractor < ProjectInfoExtractor
    private

    def extracted_info
      { warnings: reek_info }
    end

    def reek_info
      @reek_info ||= reek_json.inject({}) do |memo, warning|
        memo[warning["smell_type"]] ||= []
        memo[warning["smell_type"]] << {
          lines: warning["lines"],
          message: warning["message"],
          source: warning["source"],
          name: warning["name"],
          documentation_link: warning["documentation_link"]
        }
        memo
      end
    end

    def reek_json
      application = Reek::CLI::Application.new(
        ["--format=json", project_data_bridge.project_path]
      )

      result = OutputUtils.with_captured_stdout { application.execute }
      JSON.parse(result)
    end
  end
end
