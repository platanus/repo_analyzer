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
        rails_code_coverage: rails_code_coverage.merge(total: coverage_total)
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

    def coverage_total
      @coverage_total ||= {
        files_count: 0,
        tests_count: 0
      }
    end
  end
end
