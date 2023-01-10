module RepoAnalyzer
  class ProjectConfigExtractor < ProjectInfoExtractor
    MAKEFILE_CMDS_REGEXP = /^([\w|-]*):/
    RUBOCOP_RULES_REGEXP = %r{^([\w|/]+):}

    EXCLUDED_MAKEFILE_CMDS = %w{
      run
      help
    }

    EXCLUDED_RUBOCOP_RULES = %w{
      require
    }

    private

    def extracted_info
      {
        simplecov: simplecov?,
        makefile_commands: makefile_commands,
        rubocop_rules: rubocop_rules
      }
    end

    def simplecov?
      project_data_bridge.file_exist?("spec/simplecov_config.rb")
    end

    def makefile_commands
      extract_matches_from_content(makefile_content, MAKEFILE_CMDS_REGEXP).reject do |cmd|
        EXCLUDED_MAKEFILE_CMDS.include?(cmd)
      end
    end

    def rubocop_rules
      extract_matches_from_content(rubocop_rules_content, RUBOCOP_RULES_REGEXP).reject do |rule|
        EXCLUDED_RUBOCOP_RULES.include?(rule)
      end
    end

    def extract_matches_from_content(content, regexp)
      content.to_s.scan(regexp).flatten.sort
    end

    def makefile_content
      @makefile_content ||= project_data_bridge.file_content("Makefile")
    end

    def rubocop_rules_content
      @rubocop_rules_content ||= project_data_bridge.file_content(".rubocop.yml")
    end
  end
end
