require "spec"
require "../../src/circleci_redirection/wildcard_string"

describe CircleciRedirection::WildcardString do
  it "resembles a string" do
    wildcard = CircleciRedirection::WildcardString.new("Hello*!")
    wildcard.resembles?("Hello world!").should eq(true)
    wildcard.resembles?("Hello!").should eq(true)
    wildcard.resembles?("Hello").should eq(false)
  end
end

describe String do
  it "resembles a string" do
    "hello".resembles?("hello").should eq(true)
    "hell".resembles?("hello").should eq(false)
  end
end
