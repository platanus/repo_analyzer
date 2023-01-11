module RepoAnalyzer
  class ProjectInfoExtractor
    def initialize(project_data_bridge)
      @project_data_bridge = project_data_bridge
    end

    def extract
      key = self.class.name.underscore.split("/").last.to_sym
      { key => extracted_info.with_indifferent_access }
    end

    private

    def extracted_info
      raise RepoAnalyzer::Error.new("extracted_info method not implemented")
    end

    attr_reader :project_data_bridge
  end
end
