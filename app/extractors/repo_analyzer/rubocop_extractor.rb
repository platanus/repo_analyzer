module RepoAnalyzer
  class RubocopExtractor < ProjectInfoExtractor
    private

    def extracted_info
      { offenses: grouped_offenses_by_severit_and_cop }
    end

    def grouped_offenses_by_severit_and_cop
      result = {}

      grouped_offenses_by_severity.each do |severity, offenses|
        result[severity] = offenses.group_by do |offense|
          offense.delete(:severity)
          offense.delete(:cop)
        end
      end

      result
    end

    def grouped_offenses_by_severity
      offenses.group_by do |offense|
        offense[:severity]
      end
    end

    def offenses
      rubocop_json["files"].inject([]) do |memo, file_data|
        file_data["offenses"].each do |offense|
          memo << {
            path: offense_file_name(file_data["path"], offense),
            cop: offense["cop_name"],
            message: get_message(offense["message"]),
            severity: offense["severity"]
          }
        end
        memo
      end
    end

    def get_message(message)
      parts = message.to_s.split(": ")
      return parts.first if parts.size == 1

      parts.shift
      parts.join(": ")
    end

    def offense_file_name(file_path, offense)
      [
        file_path.gsub(%r{\A\D*#{project_data_bridge.project_path}/}, ""),
        offense['location']['line'].to_s,
        offense['location']['column'].to_s
      ].join(':')
    end

    def rubocop_json
      options, paths = RuboCop::Options.new.parse(
        [
          "--format", "json",
          "--config", Rails.root.join(".rubocop.yml").to_s,
          project_data_bridge.project_path
        ]
      )

      runner = RuboCop::Runner.new(options, RuboCop::ConfigStore.new)
      rubocop_result_content = OutputUtils.with_captured_stdout { runner.run(paths) }
      JSON.parse(rubocop_result_content)
    rescue RuboCop::Error
      { "files" => [] }
    end
  end
end
