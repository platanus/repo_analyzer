module RepoAnalyzer
  class BundlerAuditExtractor < ProjectInfoExtractor
    KEY_VALUE_REGEXP = /\A(.*):\s(.*)\z/

    private

    def extracted_info
      { vulnerabilities: audit_info }
    end

    def audit_info
      audit_collection.inject({}) do |memo, row|
        category = nil

        formatted_item = row.split("\n").inject({}) do |item, line|
          key, value = extract_key_value_form_row(line)

          if key == :criticality
            category = value
            memo[category] ||= []
            next item
          end

          item[key] = value
          item
        end

        memo[category] << formatted_item
        memo
      end
    end

    def audit_collection
      collection = audit_raw_result.split("\n\n")
      collection.pop
      collection
    end

    def extract_key_value_form_row(line)
      key, value = line.scan(KEY_VALUE_REGEXP).flatten
      key = key.gsub(" ", "_").downcase.to_sym
      [key, value]
    end

    def audit_raw_result
      `bundle-audit update`
      `bundle-audit check #{project_data_bridge.project_path}`
    end
  end
end
