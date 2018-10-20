require "../spec_helper"

describe CircleciRedirection::FetchArtifacts do
  it "returns the latest artifacts for a branch" do
    artifacts = CircleciRedirection::FetchArtifacts.new.perform(
      vcs: "github",
      user: "crystal-lang",
      branch: "master",
      repo: "crystal"
    )

    artifacts.size.should be > 1
  end

  it "raises an exception when build not found" do
    expect_raises(CircleciRedirection::FetchArtifacts::BuildNotFound) do
      CircleciRedirection::FetchArtifacts.new.perform(
        vcs: "weird-vcs",
        user: "a-random-user-that-probably-doesnt-exist",
        branch: "not-existing-branch",
        repo: "repository-nahhh"
      )
    end
  end
end
