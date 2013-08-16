require "spec_helper"

describe "prism" do
  before(:each) do
    RESULTS_FILE = "spec/test_project/.prism"

    File.delete(RESULTS_FILE) if File.exist?(RESULTS_FILE)
  end

  it "does the prism" do
    `cd spec/test_project && rspec`
    stack_trace_sets = Marshal.load(File.read(RESULTS_FILE))

    puts stack_trace_sets.keys
    stack_trace_sets["spec/test_project/adder_spec.rb:3"].should include("lib/test_project/adder.rb")
  end
end
