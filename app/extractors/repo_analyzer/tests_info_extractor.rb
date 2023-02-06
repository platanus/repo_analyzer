module RepoAnalyzer
  class TestsInfoExtractor < ProjectInfoExtractor
    TESTEABLE_RAILS_RESOURCES = %i{
      controllers
      mailers
      models
      jobs
      policies
      commands
      services
      observers
      values
      utils
      clients
    }

    EXCLUDED_FILES = %w{
      previews
      application_record
      application_controller
      base_controller
      application_job
      concern
      application_mailer
      application_policy
      default_policy
      admin_user_policy
      comment_policy
      page_policy
    }

    private

    def extracted_info
      {
        swagger_tests_count: swagger_tests,
        system_tests_count: system_tests_count,
        jest_tests_count: jest_tests_count,
        rails_code_coverage: rails_code_coverage.merge(total: coverage_total),
        simplecov_coverage: simplecov_coverage.merge(total: simplecov_total_percentage)
      }
    end

    def swagger_tests
      project_data_bridge.dir_files("spec/integration").count
    end

    def system_tests_count
      project_data_bridge.dir_files("spec/system").count
    end

    def jest_tests_count
      project_data_bridge.dir_files("app/javascript").count do |file|
        file.include?("spec.js")
      end
    end

    def simplecov_coverage
      @simplecov_coverage ||= TESTEABLE_RAILS_RESOURCES.inject({}) do |data, resource|
        covered_percent = coverage_file.dig(
          "groups", resource.to_s.camelize, "lines", "covered_percent"
        )
        value = covered_percent&.to_f&.round(2)
        data[resource] = value
        add_value_to_simplecov_total(value) if value
        data
      end
    end

    def add_value_to_simplecov_total(value)
      @simplecov_covered_total ||= 0
      @simplecov_covered_total += value
      @simplecov_total ||= 0
      @simplecov_total += 100
    end

    def coverage_file
      @coverage_file ||= begin
        content = project_data_bridge.file_content("coverage/coverage.json")
        return {} if content.blank?

        JSON.parse(content).with_indifferent_access
      end
    end

    def rails_code_coverage
      TESTEABLE_RAILS_RESOURCES.inject({}) do |data, resource|
        tests_count = project_data_bridge.dir_files("spec/#{resource}").count do |file|
          valid_file?(file)
        end
        files_count = project_data_bridge.dir_files("app/#{resource}").count do |file|
          valid_file?(file)
        end
        data[resource] = { files_count: files_count, tests_count: tests_count }
        coverage_total[:files_count] += files_count
        coverage_total[:tests_count] += tests_count
        data
      end
    end

    def valid_file?(file)
      EXCLUDED_FILES.each do |key|
        return false if file.include?(key) || !file.ends_with?(".rb")
      end

      true
    end

    def simplecov_total_percentage
      @simplecov_total_percentage ||= begin
        return if @simplecov_covered_total.nil? || @simplecov_total.nil?

        (@simplecov_covered_total / @simplecov_total * 100.0).round(2)
      end
    end

    def coverage_total
      @coverage_total ||= {
        files_count: 0,
        tests_count: 0
      }
    end
  end
end
