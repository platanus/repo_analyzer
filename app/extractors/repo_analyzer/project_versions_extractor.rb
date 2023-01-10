module RepoAnalyzer
  class ProjectVersionsExtractor < ProjectInfoExtractor
    CI_VERSION_REGEXP = /^version:\s(\d)/
    RAILS_VERSION_REGEX = /^\s{4}rails \((\d.*)\)/
    PAPERCLIP_VERSION = /^\s{4}paperclip \((\d.*)\)/
    SHRINE_VERSION = /^\s{4}shrine \((\d.*)\)/
    RUBOCOP_VERSION = /^\s{4}rubocop \((\d.*)\)/
    SIDEKIQ_VERSION = /^\s{4}sidekiq \((\d.*)\)/

    private

    def extracted_info
      {
        rails_version: gem_version(RAILS_VERSION_REGEX),
        node_version: package_version("engines.node"),
        vue_version: package_version("dependencies.vue"),
        vue_router_version: package_version("dependencies.vue-router"),
        typescript_version: package_version("dependencies.typescript"),
        tailwind_version: tailwind_version,
        paperclip_version: gem_version(PAPERCLIP_VERSION),
        shrine_version: gem_version(SHRINE_VERSION),
        sidekiq_version: gem_version(SIDEKIQ_VERSION),
        circleci_version: circleci_version,
        rubocop_version: gem_version(RUBOCOP_VERSION),
        eslint_version: package_version("devDependencies.eslint"),
        stylelint_version: package_version("devDependencies.stylelint")
      }
    end

    def tailwind_version
      return "2" if package_json_content.to_s.include?("postcss7-compat")

      package_version("dependencies.tailwindcss")
    end

    def gem_version(regexp)
      gemfile_content&.match(regexp)&.captures&.first
    end

    def package_version(dependency)
      content = package_json_content
      return nil if content.blank?

      version = JSON.parse(content)
                    .dig(*dependency.split(".")).to_s.split("")
                    .select do |value|
        value == "." || int?(value)
      end

      version.pop if version.last == "."
      return version.join("") if version.present?

      nil
    rescue JSON::ParserError
      nil
    end

    def circleci_version
      ci_config_content&.match(CI_VERSION_REGEXP)&.captures&.first
    end

    def int?(value)
      Integer(value)
    rescue ArgumentError
      false
    end

    def package_json_content
      @package_json_content ||= project_data_bridge.file_content("package.json")
    end

    def gemfile_content
      @gemfile_content ||= project_data_bridge.file_content("Gemfile.lock")
    end

    def ci_config_content
      @ci_config_content ||= project_data_bridge.file_content(".circleci/config.yml")
    end
  end
end
