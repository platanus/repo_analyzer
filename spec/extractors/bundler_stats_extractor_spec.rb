require 'rails_helper'

describe RepoAnalyzer::BundlerStatsExtractor, repo_analyzer_extractor_helpers: true do
  describe "#extract" do
    let(:stats) do
      {
        "summary": {
          "declared": 10,
          "unpinned": 9,
          "total": 117,
          "github": 0
        },
        "gems": [
          {
            "name": "repo_analyzer",
            "total_dependencies": 84,
            "first_level_dependencies": 14,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "brakeman (>= 0)",
              "bundler-audit (>= 0)",
              "bundler-stats (>= 0)",
              "faraday-retry (>= 0)",
              "fasterer (>= 0)",
              "octokit (~> 4.0)",
              "rails (>= 6.0)",
              "rails_best_practices (>= 0)",
              "reek (>= 0)",
              "rubocop (~> 1.9)",
              "rubocop-performance (>= 0)",
              "rubocop-platanus (~> 0.2)",
              "rubocop-rails (>= 0)",
              "rubocop-rspec (~> 2.2)",
              "bundler (>= 1.2.0, < 3)",
              "thor (~> 1.0)",
              "faraday (~> 2.0)",
              "faraday-net_http (>= 2.0, < 3.1)",
              "ruby2_keywords (>= 0.0.4)",
              "colorize (~> 0.7)",
              "ruby_parser (>= 3.19.1)",
              "sexp_processor (~> 4.16)",
              "sawyer (~> 0.9)",
              "addressable (>= 2.3.5)",
              "public_suffix (>= 2.0.2, < 6.0)",
              "actioncable (= 6.1.7)",
              "actionmailbox (= 6.1.7)",
              "actionmailer (= 6.1.7)",
              "actionpack (= 6.1.7)",
              "actiontext (= 6.1.7)",
              "actionview (= 6.1.7)",
              "activejob (= 6.1.7)",
              "activemodel (= 6.1.7)",
              "activerecord (= 6.1.7)",
              "activestorage (= 6.1.7)",
              "activesupport (= 6.1.7)",
              "railties (= 6.1.7)",
              "sprockets-rails (>= 2.0.0)",
              "nio4r (~> 2.0)",
              "websocket-driver (>= 0.6.1)",
              "rack (~> 2.0, >= 2.0.9)",
              "rack-test (>= 0.6.3)",
              "rails-dom-testing (~> 2.0)",
              "rails-html-sanitizer (~> 1.0, >= 1.2.0)",
              "builder (~> 3.1)",
              "erubi (~> 1.4)",
              "concurrent-ruby (~> 1.0, >= 1.0.2)",
              "i18n (>= 1.6, < 2)",
              "minitest (>= 5.1)",
              "tzinfo (~> 2.0)",
              "zeitwerk (~> 2.3)",
              "nokogiri (>= 1.6)",
              "mini_portile2 (~> 2.8.0)",
              "racc (~> 1.4)",
              "loofah (~> 2.3)",
              "crass (~> 1.0.2)",
              "websocket-extensions (>= 0.1.0)",
              "mail (>= 2.7.1)",
              "globalid (>= 0.3.6)",
              "marcel (~> 1.0)",
              "mini_mime (>= 1.1.0)",
              "net-imap (>= 0)",
              "net-pop (>= 0)",
              "net-smtp (>= 0)",
              "date (>= 0)",
              "net-protocol (>= 0)",
              "timeout (>= 0)",
              "method_source (>= 0)",
              "rake (>= 12.2)",
              "sprockets (>= 3.0.0)",
              "code_analyzer (~> 0.5.5)",
              "erubis (>= 0)",
              "json (>= 0)",
              "require_all (~> 3.0)",
              "ruby-progressbar (>= 0)",
              "kwalify (~> 0.7.0)",
              "parser (~> 3.2.0)",
              "rainbow (>= 2.0, < 4.0)",
              "rexml (~> 3.1)",
              "ast (~> 2.4.1)",
              "parallel (~> 1.10)",
              "regexp_parser (>= 1.8, < 3.0)",
              "rubocop-ast (>= 1.23.0, < 2.0)",
              "unicode-display_width (>= 1.4.0, < 3.0)"
            ]
          },
          {
            "name": "rspec-rails",
            "total_dependencies": 28,
            "first_level_dependencies": 7,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "actionpack (>= 6.1)",
              "activesupport (>= 6.1)",
              "railties (>= 6.1)",
              "rspec-core (~> 3.11)",
              "rspec-expectations (~> 3.11)",
              "rspec-mocks (~> 3.11)",
              "rspec-support (~> 3.11)",
              "actionview (= 6.1.7)",
              "rack (~> 2.0, >= 2.0.9)",
              "rack-test (>= 0.6.3)",
              "rails-dom-testing (~> 2.0)",
              "rails-html-sanitizer (~> 1.0, >= 1.2.0)",
              "builder (~> 3.1)",
              "erubi (~> 1.4)",
              "concurrent-ruby (~> 1.0, >= 1.0.2)",
              "i18n (>= 1.6, < 2)",
              "minitest (>= 5.1)",
              "tzinfo (~> 2.0)",
              "zeitwerk (~> 2.3)",
              "nokogiri (>= 1.6)",
              "mini_portile2 (~> 2.8.0)",
              "racc (~> 1.4)",
              "loofah (~> 2.3)",
              "crass (~> 1.0.2)",
              "method_source (>= 0)",
              "rake (>= 12.2)",
              "thor (~> 1.0)",
              "diff-lcs (>= 1.2.0, < 2.0)"
            ]
          },
          {
            "name": "factory_bot_rails",
            "total_dependencies": 24,
            "first_level_dependencies": 2,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "factory_bot (~> 6.2.0)",
              "railties (>= 5.0.0)",
              "activesupport (>= 5.0.0)",
              "concurrent-ruby (~> 1.0, >= 1.0.2)",
              "i18n (>= 1.6, < 2)",
              "minitest (>= 5.1)",
              "tzinfo (~> 2.0)",
              "zeitwerk (~> 2.3)",
              "actionpack (= 6.1.7)",
              "method_source (>= 0)",
              "rake (>= 12.2)",
              "thor (~> 1.0)",
              "actionview (= 6.1.7)",
              "rack (~> 2.0, >= 2.0.9)",
              "rack-test (>= 0.6.3)",
              "rails-dom-testing (~> 2.0)",
              "rails-html-sanitizer (~> 1.0, >= 1.2.0)",
              "builder (~> 3.1)",
              "erubi (~> 1.4)",
              "nokogiri (>= 1.6)",
              "mini_portile2 (~> 2.8.0)",
              "racc (~> 1.4)",
              "loofah (~> 2.3)",
              "crass (~> 1.0.2)"
            ]
          },
          {
            "name": "guard-rspec",
            "total_dependencies": 21,
            "first_level_dependencies": 3,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "guard (~> 2.1)",
              "guard-compat (~> 1.1)",
              "rspec (>= 2.99.0, < 4.0)",
              "formatador (>= 0.2.4)",
              "listen (>= 2.7, < 4.0)",
              "lumberjack (>= 1.0.12, < 2.0)",
              "nenv (~> 0.1)",
              "notiffany (~> 0.0)",
              "pry (>= 0.13.0)",
              "shellany (~> 0.0)",
              "thor (>= 0.18.1)",
              "rb-fsevent (~> 0.10, >= 0.10.3)",
              "rb-inotify (~> 0.9, >= 0.9.10)",
              "ffi (~> 1.0)",
              "coderay (~> 1.1)",
              "method_source (~> 1.0)",
              "rspec-core (~> 3.12.0)",
              "rspec-expectations (~> 3.12.0)",
              "rspec-mocks (~> 3.12.0)",
              "rspec-support (~> 3.12.0)",
              "diff-lcs (>= 1.2.0, < 2.0)"
            ]
          },
          {
            "name": "coveralls",
            "total_dependencies": 8,
            "first_level_dependencies": 5,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "json (>= 1.8, < 3)",
              "simplecov (~> 0.16.1)",
              "term-ansicolor (~> 1.3)",
              "thor (>= 0.19.4, < 2.0)",
              "tins (~> 1.6)",
              "docile (~> 1.1)",
              "simplecov-html (~> 0.10.0)",
              "sync (>= 0)"
            ]
          },
          {
            "name": "pry-rails",
            "total_dependencies": 3,
            "first_level_dependencies": 1,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "pry (>= 0.10.4)",
              "coderay (~> 1.1)",
              "method_source (~> 1.0)"
            ]
          },
          {
            "name": "pry",
            "total_dependencies": 2,
            "first_level_dependencies": 2,
            "top_level_dependencies": {
              "guard": "guard (2.18.0)",
              "guard-rspec": "guard-rspec (4.7.3)",
              "pry-rails": "pry-rails (0.3.9)"
            },
            "transitive_dependencies": [
              "coderay (~> 1.1)",
              "method_source (~> 1.0)"
            ]
          },
          {
            "name": "rspec_junit_formatter",
            "total_dependencies": 2,
            "first_level_dependencies": 1,
            "top_level_dependencies": {},
            "transitive_dependencies": [
              "rspec-core (>= 2, < 4, != 2.12.0)",
              "rspec-support (~> 3.12.0)"
            ]
          },
          {
            "name": "bundler",
            "total_dependencies": 0,
            "first_level_dependencies": 0,
            "top_level_dependencies": {
              "bundler-audit": "bundler-audit (0.9.1)",
              "bundler-stats": "bundler-stats (2.3.0)",
              "rails": "rails (6.1.7)",
              "repo_analyzer": "repo_analyzer (1.3.0)"
            },
            "transitive_dependencies": []
          },
          {
            "name": "sqlite3",
            "total_dependencies": 0,
            "first_level_dependencies": 0,
            "top_level_dependencies": {},
            "transitive_dependencies": []
          }
        ]
      }
    end

    before do
      allow(extractor).to receive(:`).with(
        'bundle exec bundle-stats stats -f json'
      ).and_return(stats.to_json)
    end

    it { expect(extract[:bundler_stats_extractor]).to eq(stats.with_indifferent_access) }
  end
end
