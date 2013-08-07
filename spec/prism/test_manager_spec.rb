require "spec_helper"

describe "TestManager" do
  describe "run" do
    it "runs the test group if necessary" do
      pending
      Core.any_instance.stubs(:get_saved_trace).returns(Set.new(["foo.rb"]))
    end

    it "reports the tests as not run if not necesary"
  end
end
