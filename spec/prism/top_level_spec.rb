# require "spec_helper"
#
# def run_tests
#   `cd spec/test_project && rspec`
# end
#
# describe "prism" do
#   RESULTS_FILE = "spec/test_project/.prism"
#
#   before(:each) do
#     File.delete(RESULTS_FILE) if File.exist?(RESULTS_FILE)
#   end
#
#   it "saves a map of stack traces" do
#     run_tests
#     stack_trace_sets = Marshal.load(File.read(RESULTS_FILE))
#
#     puts stack_trace_sets.keys
#     stack_trace_sets["spec/test_project/adder_spec.rb:3"].should include("lib/test_project/adder.rb")
#   end
#
#   it "identifies which tests would be affected by the diff" do
#     run_tests
#
#     Prism::Configuration.project_root = "spec/test_project"
#     Prism::Configuration.diff = File.open("spec/test_project/diff").read
#
#     core = Core.new(RSpecStackTraceGenerator.new)
#     core.tests_needed_to_run.should include("spec/test_project/adder_spec.rb:3")
#     core.tests_needed_to_run.should_not include("spec/test_project/subtracter_spec.rb")
#   end
# end
