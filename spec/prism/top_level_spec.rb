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
    stack_trace_sets = Marshal.load(File.read(RESULTS_FILE))

    stack_trace_sets["spec/test_project/adder_spec.rb:3"].file_set.should include("lib/test_project/adder.rb")
  end

  it "identifies which tests would be affected by the diff" do
    run_tests

    config = Prism::Configuration.new("spec/test_project", File.open("spec/test_project/diff").read)

    config.core.tests_needed_to_run.should include("spec/test_project/adder_spec.rb:3")
    config.core.tests_needed_to_run.should_not include("spec/test_project/subtracter_spec.rb")
  end
end
