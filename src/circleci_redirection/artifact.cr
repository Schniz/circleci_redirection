require "json"

module CircleciRedirection
  class Artifact
    JSON.mapping(
      path: String,
      url: String
    )

    def path_matches?(other)
      other.resembles?(path)
    end
  end
end
