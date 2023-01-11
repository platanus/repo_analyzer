module RepoAnalyzer
  class PowerTypesExtractor < ProjectInfoExtractor
    POWERTYPES = %i{
      commands
      services
      observers
      values
      utils
      clients
    }

    private

    def extracted_info
      POWERTYPES.inject({}) do |memo, type|
        memo[type] = project_data_bridge.dir_files("app/#{type}").any?
        memo
      end
    end
  end
end
