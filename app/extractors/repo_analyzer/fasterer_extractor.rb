require "fasterer/file_traverser"

module RepoAnalyzer
  class FastererExtractor < ProjectInfoExtractor
    private

    def extracted_info
      { speedups: fasterer_info }
    end

    def fasterer_info
      @fasterer_info ||= fasterer_text.split("\n").inject([]) do |memo, row|
        next memo if row.blank?

        row_parts = row.split("\e")
        file_path_and_line = row_parts.second.gsub('[0;31;49m', '')
        file_path, line = file_path_and_line.split(':')
        next memo if file_path.include?("files inspected")

        message = row_parts.last.gsub('[0m ', '')
        memo << {
          file_path: file_path,
          line: line,
          message: message
        }
      end
    end

    def fasterer_text
      file_traverser = Fasterer::FileTraverser.new(".")
      OutputUtils.with_captured_stdout { file_traverser.traverse }
    end
  end
end
