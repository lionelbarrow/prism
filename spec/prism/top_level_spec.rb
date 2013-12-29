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
    locations = stack_traces.map { |trace| trace["location"] }
    locations.should include("spec/test_project/subtracter_spec.rb:3")
    locations.should include("spec/test_project/adder_spec.rb:3")
  end
end
