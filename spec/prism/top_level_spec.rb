require "spec_helper"

def run_tests
  `cd spec/test_project && rspec`
end

describe "prism" do
  RESULTS_FILE = "spec/test_project/.prism"

  before(:each) do
    File.delete(RESULTS_FILE) if File.exist?(RESULTS_FILE)
  end

  it "saves a map of stack traces" do
    run_tests
    stack_traces = JSON.load(File.read(RESULTS_FILE))
    stack_traces["spec/test_project/subtracter_spec.rb:3"].should_not be_nil
    stack_traces["spec/test_project/adder_spec.rb:3"].should_not be_nil
  end
end
