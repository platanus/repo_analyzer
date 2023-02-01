module RepoAnalyzer
  class ExtractProjectInfoJob < ApplicationJob
    def perform(repo_name)
      project_info = {}
      bridge = RepoAnalyzer::ProjectDataBridge.new(repo_name)

      for_each_extractor do |extractor|
        extracted_data = extractor.new(bridge).extract
        project_info.merge!(extracted_data)
      end

      project_info
    end

    private

    def for_each_extractor(&block)
      extractors_from_directory.each do |extractor|
        next if extractor == ::RepoAnalyzer::ProjectInfoExtractor

        block.call(extractor)
      end
    end

    def extractors_from_directory
      Dir[
        RepoAnalyzer::Engine.root.join("app/extractors/repo_analyzer/*.rb")
      ].map do |path|
        file_name = path.split('/').last
        extractor_name = file_name.split('.').first.camelize
        Object.const_get("::RepoAnalyzer::#{extractor_name}")
      end
    end
  end
end
