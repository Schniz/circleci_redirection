require "./artifact"

module CircleciRedirection
  class SearchArtifact
    class FileNotFound < Exception; end

    getter artifacts

    def initialize(@artifacts : Array(Artifact))
    end

    def find!(path)
      artifact = find(path)
      raise FileNotFound.new("File '#{path}' not found in build") if artifact.nil?
      artifact
    end

    def find(path)
      artifact = artifacts.find(&.path_matches?(path))
      if artifact.nil?
        new_path = path + "/index.html"
        artifact = artifacts.find(&.path_matches?(new_path))
      end
      artifact
    end
  end
end
