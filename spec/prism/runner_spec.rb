require "spec_helper"

describe Prism::Runner do
  describe "run_group!" do
    it "runs the example group and records the files needed to run" do
      runner = Prism::Runner.new("")

      example_group = RSpec::Core::ExampleGroup.describe("my favorite class")
      example_group.example("foos the bar") do
        object = TestClass.new
        object.invoke_a_method
      end

      runner.run_group!(example_group, NullObject.new)
      runner.results.first["location"].should == "spec/prism/runner_spec.rb:8"
    end

    it "saves each stack trace to a unique location" do
      runner = Prism::Runner.new("")

      example_group_one = RSpec::Core::ExampleGroup.describe("my favorite class")
      example_group_one.example("foos the bar") do
        object = TestClass.new
        object.invoke_a_method
      end

      runner.run_group!(example_group_one, NullObject.new)

      example_group_two = RSpec::Core::ExampleGroup.describe("a class I don't like")
      example_group_two.example("bars the foo") do
        object = TestClass.new
        object.invoke_a_bad_method
      end

      runner.run_group!(example_group_two, NullObject.new)

      runner.results.first["location"].should == "spec/prism/runner_spec.rb:21"
      runner.results[1]["location"].should == "spec/prism/runner_spec.rb:29"
    end
  end
end
