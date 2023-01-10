class GithubClient
  def initialize(personal_token)
    @personal_token = personal_token
  end

  def contributors(repo_name)
    client.contributors(repo_name, true)
  end

  def commits(repo_name, from_date: nil, to_date: nil)
    from_date ||= Date.current - 2.years
    to_date ||= Date.tomorrow
    client.commits_between(repo_name, from_date.to_s, to_date.to_s)
  end

  def file_content(repo_name, file_path)
    Base64.decode64(client.content(repo_name, path: file_path)[:content])
  rescue Octokit::NotFound
    ""
  end

  private

  attr_reader :personal_token

  def client
    @client ||= Octokit::Client.new(access_token: personal_token, per_page: 10000)
  end
end
