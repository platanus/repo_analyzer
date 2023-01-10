module RepoAnalyzer
  class CircleciExtractor < ProjectInfoExtractor
    COVERAGE_REGEXP = /(coverage)/
    RUBOCOP_REGEXP = /(rubocop)/
    ESLINT_REGEXP = /(eslint)/
    STYLELINT_REGEXP = /(stylelint)/
    JEST_REGEXP = /(yarn\srun\stest)/
    JEST_REGEXP_ALT = /(cibuild\sjs_tests)/
    RSPEC_REGEXP = /(rspec\.xml)/
    RSPEC_REGEXP_ALT = /(cibuild\stests)/
    SYSTEM_REGEXP = /(rspec-system\.xml)/
    PLATANUS_COMPOSE_REGEXP = %r{(platanus\/compose)}

    private

    def extracted_info
      {
        platanus_compose: content_by_regexp?(PLATANUS_COMPOSE_REGEXP),
        jest: content_by_regexp?(JEST_REGEXP, JEST_REGEXP_ALT),
        rspec: content_by_regexp?(RSPEC_REGEXP, RSPEC_REGEXP_ALT),
        system_tests: content_by_regexp?(SYSTEM_REGEXP),
        code_coverage: content_by_regexp?(COVERAGE_REGEXP),
        rubocop: content_by_regexp?(RUBOCOP_REGEXP),
        eslint: content_by_regexp?(ESLINT_REGEXP),
        stylelint: content_by_regexp?(STYLELINT_REGEXP)
      }
    end

    def content_by_regexp?(*regexps)
      !!content_by_regexp(regexps)
    end

    def content_by_regexp(regexps)
      regexps.each do |regexp|
        is_valid = config_content&.match(regexp)&.captures&.first
        return true if is_valid
      end

      false
    end

    def config_content
      @config_content ||= project_data_bridge.file_content(".circleci/config.yml")
    end
  end
end
