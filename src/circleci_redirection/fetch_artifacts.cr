require "json"
require "./artifact"

module CircleciRedirection
  class FetchArtifacts
    class BuildNotFound < Exception; end
    BASE_URL = "https://circleci.com/api/v1.1/project"

    getter vcs, user, repo, branch, base_url

    def self.perform(**args)
      new.perform(**args)
    end

    def perform(@vcs : String, @user : String, @repo : String, @branch : String, @base_url : String = BASE_URL)
      artifacts_url = "#{base_url}/#{vcs}/#{user}/#{repo}/latest/artifacts?branch=#{branch}&filter=successful"
      body = http_get(artifacts_url).body
      Array(Artifact).from_json(body)
    rescue JSON::ParseException
      raise BuildNotFound.new("Build not found")
    end

    private def http_get(url)
      headers = HTTP::Headers.new
      headers["Accept"] = "application/json"
      HTTP::Client.get(url, headers: headers)
    end
  end
end
