require 'rails_helper'

describe RepoAnalyzer::BundlerAuditExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:audit_result_content) do
      <<~TEXT
        Name: actionpack
        Version: 6.1.7
        CVE: CVE-2023-22792
        GHSA: GHSA-p84v-45xj-wwqj
        Criticality: Unknown
        URL: https://github.com/rails/rails/releases/tag/v7.0.4.1
        Title: ReDoS based DoS vulnerability in Action Dispatch
        Solution: upgrade to '~> 5.2.8, >= 5.2.8.15', '~> 6.1.7, >= 6.1.7.1', '>= 7.0.4.1'

        Name: actionpack
        Version: 6.1.7
        CVE: CVE-2023-22795
        GHSA: GHSA-8xww-x3g3-6jcv
        Criticality: Unknown
        URL: https://github.com/rails/rails/releases/tag/v7.0.4.1
        Title: ReDoS based DoS vulnerability in Action Dispatch
        Solution: upgrade to '~> 5.2.8, >= 5.2.8.15', '~> 6.1.7, >= 6.1.7.1', '>= 7.0.4.1'

        Name: activerecord
        Version: 6.1.7
        CVE: CVE-2022-44566
        GHSA: GHSA-579w-22j4-4749
        Criticality: High
        URL: https://github.com/rails/rails/releases/tag/v7.0.4.1
        Title: Denial of Service Vulnerability in ActiveRecord's PostgreSQL adapter
        Solution: upgrade to '~> 5.2.8, >= 5.2.8.15', '~> 6.1.7, >= 6.1.7.1', '>= 7.0.4.1'

        Name: activerecord
        Version: 6.1.7
        CVE: CVE-2023-22794
        GHSA: GHSA-hq7p-j377-6v63
        Criticality: High
        URL: https://github.com/rails/rails/releases/tag/v7.0.4.1
        Title: SQL Injection Vulnerability via ActiveRecord comments
        Solution: upgrade to '~> 6.0.6, >= 6.0.6.1', '~> 6.1.7, >= 6.1.7.1', '>= 7.0.4.1'

        Name: loofah
        Version: 2.19.0
        CVE: CVE-2022-23515
        GHSA: GHSA-228g-948r-83gx
        Criticality: Medium
        URL: https://github.com/flavorjones/loofah/security/advisories/GHSA-228g-948r-83gx
        Title: Improper neutralization of data URIs may allow XSS in Loofah
        Solution: upgrade to '>= 2.19.1'

        Name: rails-html-sanitizer
        Version: 1.4.3
        CVE: CVE-2022-23520
        GHSA: GHSA-rrfc-7g8p-99q8
        Criticality: Medium
        URL: https://github.com/rails/rails-html-sanitizer/security/advisories/GHSA-rrfc-7g8p-99q8
        Title: Possible XSS vulnerability with certain configurations of rails-html-sanitizer
        Solution: upgrade to '>= 1.4.4'

        Vulnerabilities found!
      TEXT
    end

    before do
      allow(extractor).to receive(:`).with('bundle-audit update')
      allow(extractor).to receive(:`).with('bundle-audit check spec/assets/test_project').and_return(audit_result_content)
    end

    let(:expected) do
      {
        "vulnerabilities" => {
          "Unknown" => [
            {
              name: "actionpack",
              version: "6.1.7",
              cve: "CVE-2023-22792",
              ghsa: "GHSA-p84v-45xj-wwqj",
              url: "https://github.com/rails/rails/releases/tag/v7.0.4.1",
              title: "ReDoS based DoS vulnerability in Action Dispatch",
              solution: "upgrade to '~> 5.2.8, >= 5.2.8.15', '~> 6.1.7, >= 6.1.7.1', '>= 7.0.4.1'"
            },
            {
              name: "actionpack",
              version: "6.1.7",
              cve: "CVE-2023-22795",
              ghsa: "GHSA-8xww-x3g3-6jcv",
              url: "https://github.com/rails/rails/releases/tag/v7.0.4.1",
              title: "ReDoS based DoS vulnerability in Action Dispatch",
              solution: "upgrade to '~> 5.2.8, >= 5.2.8.15', '~> 6.1.7, >= 6.1.7.1', '>= 7.0.4.1'"
            }
          ],
          "High" => [
            {
              name: "activerecord",
              version: "6.1.7",
              cve: "CVE-2022-44566",
              ghsa: "GHSA-579w-22j4-4749",
              url: "https://github.com/rails/rails/releases/tag/v7.0.4.1",
              title: "Denial of Service Vulnerability in ActiveRecord's PostgreSQL adapter",
              solution: "upgrade to '~> 5.2.8, >= 5.2.8.15', '~> 6.1.7, >= 6.1.7.1', '>= 7.0.4.1'"
            },
            {
              name: "activerecord",
              version: "6.1.7",
              cve: "CVE-2023-22794",
              ghsa: "GHSA-hq7p-j377-6v63",
              url: "https://github.com/rails/rails/releases/tag/v7.0.4.1",
              title: "SQL Injection Vulnerability via ActiveRecord comments",
              solution: "upgrade to '~> 6.0.6, >= 6.0.6.1', '~> 6.1.7, >= 6.1.7.1', '>= 7.0.4.1'"
            }
          ],
          "Medium" => [
            {
              name: "loofah",
              version: "2.19.0",
              cve: "CVE-2022-23515",
              ghsa: "GHSA-228g-948r-83gx",
              url: "https://github.com/flavorjones/loofah/security/advisories/GHSA-228g-948r-83gx",
              title: "Improper neutralization of data URIs may allow XSS in Loofah",
              solution: "upgrade to '>= 2.19.1'"
            },
            {
              name: "rails-html-sanitizer",
              version: "1.4.3",
              cve: "CVE-2022-23520",
              ghsa: "GHSA-rrfc-7g8p-99q8",
              url: "https://github.com/rails/rails-html-sanitizer/security/advisories/GHSA-rrfc-7g8p-99q8",
              title: "Possible XSS vulnerability with certain configurations of rails-html-sanitizer",
              solution: "upgrade to '>= 1.4.4'"
            }
          ]
        }
      }.with_indifferent_access
    end

    it { expect(extract[:bundler_audit_extractor]).to eq(expected) }
  end
end
