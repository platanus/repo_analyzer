# Repo Analyzer

[![Gem Version](https://badge.fury.io/rb/repo_analyzer.svg)](https://badge.fury.io/rb/repo_analyzer)
[![CircleCI](https://circleci.com/gh/platanus/repo_analyzer.svg?style=shield)](https://app.circleci.com/pipelines/github/platanus/repo_analyzer)

Rails engine to extract useful information about the project.

## Installation

Add to your Gemfile:

```ruby
gem "repo_analyzer"
```

```bash
bundle install
```

Run the installer:

```bash
rails generate repo_analyzer:install
```

Then, configure ENV vars:

- `GITHUB_PERSONAL_TOKEN`: to extract commits info.
- `REPO_ANALYZER_URL`: POST endpoint where you want to process extracted info.

## Usage

In order to extract the information you can execute:

```ruby
RepoAnalyzer::ExtractProjectInfoJob.perform_now("github-repo-name")
```

Example:

```ruby
project_info = RepoAnalyzer::ExtractProjectInfoJob.perform_now("platanus/example-project")
```

You will get something like this:

```ruby
{
  circleci_extractor: {
    "platanus_compose" => false,
    "jest" => true,
    "rspec" => true,
    "system_tests" => true,
    "code_coverage" => true,
    "rubocop" => true,
    "eslint" => true,
    "stylelint" => true
  },
  github_extractor: {
    "last_commit_date" => "2023-01-25",
    "last_contributors" => [
      {
        "login" => "flouMicaza",
        "avatar_url" => "https://avatars.githubusercontent.com/u/24324363?v=4",
        "contributions" => 316
      },
      {
        "login" => "ankaph",
        "avatar_url" => "https://avatars.githubusercontent.com/u/1688697?v=4",
        "contributions" => 207
      }
    ],
    "contributors" => [
      {
        "login" => "flouMicaza",
        "avatar_url" => "https://avatars.githubusercontent.com/u/24324363?v=4",
        "contributions" => 316
      },
      {
        "login" => "ankaph",
        "avatar_url" => "https://avatars.githubusercontent.com/u/1688697?v=4",
        "contributions" => 207
      }
    ]
  },
  power_types_extractor: {
    "commands" => false,
    "services" => false,
    "observers" => true,
    "values" => false,
    "utils" => true,
    "clients" => true
  },
  # ...
}
```

Each key (`circleci_extractor`, `github_extractor`, `power_types_extractor`, etc) contains useful information about the project that you can use whatever you want.
Extractors live here: https://github.com/platanus/repo_analyzer/tree/master/app/extractors/repo_analyzer

Then, the extracted information can be posted to some endpoint defined on this ENV var `REPO_ANALYZER_URL` executing:

```ruby
RepoAnalyzer::PostExtractedInfoJob.perform_now("platanus/example-project", project_info)
```

### Script

You can extract and POST the info using the following rake task:

```bash
bin/rake "repo_analyzer:analyze[github-repo-name]"
```

Example:

```bash
`bin/rake "repo_analyzer:analyze[platanus/example-project]"`
```

## Development

You can add a new extractor here: https://github.com/platanus/repo_analyzer/tree/master/app/extractors/repo_analyzer
This one must implement methods defined on this base class: https://github.com/platanus/repo_analyzer/blob/master/app/extractors/repo_analyzer/project_info_extractor.rb#L14

## Testing

To run the specs you need to execute, in the root path of the engine, the following command:

```bash
bundle exec guard
```

You need to put **all your tests** in the `/repo_analyzer/spec` directory.

## Publishing

On master/main branch...

1. Change `VERSION` in `lib/repo_analyzer/version.rb`.
2. Change `Unreleased` title to current version in `CHANGELOG.md`.
3. Run `bundle install`.
4. Commit new release. For example: `Releasing v0.1.0`.
5. Create tag. For example: `git tag v0.1.0`.
6. Push tag. For example: `git push origin v0.1.0`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/repo_analyzer/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

Repo Analyzer is maintained by [platanus](http://platan.us).

## License

Repo Analyzer is © 2023 platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
