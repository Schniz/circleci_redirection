require "./fetch_artifacts"
require "./search_artifact"
require "./wildcard_string"
require "./markdown_to_html"
require "kemal"
require "markdown"

module CircleciRedirection
  get "/" do |ctx|
    MarkdownToHtml.grip("README.md")
  end

  get "/wildcard/github/:repo_owner/:repo/:branch/*path" do |ctx|
    vcs = "github"
    branch = ctx.params.url["branch"]
    repo_owner = ctx.params.url["repo_owner"]
    repo = ctx.params.url["repo"]
    path = WildcardString.new(ctx.params.url["path"].without_trailing_slash)

    artifacts = FetchArtifacts.perform(vcs: vcs, user: repo_owner, repo: repo, branch: branch)
    redirect_url = SearchArtifact.new(artifacts).find!(path).url
    ctx.redirect redirect_url
  rescue e : FetchArtifacts::BuildNotFound | SearchArtifact::FileNotFound
    halt ctx, status_code: 404, response: e.message
  end

  get "/file/github/:repo_owner/:repo/:branch/*path" do |ctx|
    vcs = "github"
    branch = ctx.params.url["branch"]
    repo_owner = ctx.params.url["repo_owner"]
    repo = ctx.params.url["repo"]
    path = ctx.params.url["path"].without_trailing_slash

    artifacts = FetchArtifacts.perform(vcs: vcs, user: repo_owner, repo: repo, branch: branch)
    redirect_url = SearchArtifact.new(artifacts).find!(path).url
    ctx.redirect redirect_url
  rescue e : FetchArtifacts::BuildNotFound | SearchArtifact::FileNotFound
    halt ctx, status_code: 404, response: e.message
  end

  error 404 do
    "Can't find this artifact on CircleCI! this is case sensitive, so please check your URL again."
  end

  error 500 do
    "Something messed up on our side. Sorry!"
  end

  module Web
    def self.run!
      Kemal.run
    end
  end
end
