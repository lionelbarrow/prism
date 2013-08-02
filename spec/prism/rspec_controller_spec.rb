require "spec_helper"

describe RSpecController do
  before(:each) do
    stub_rspec_example_groups
  end

  after(:each) do
    restore_rspec_example_groups
  end

  describe "files_in_scope_for_group" do
    it "generates a set of files" do
      controller = RSpecController.new

      example_group = RSpec::Core::ExampleGroup.describe("my favorite class")
      example_group.example("foos the bar") do
        object = TestClass.new
        object.invoke_a_method
      end

      controller.files_in_scope_for_group(example_group).should include("prism/spec/spec_helper.rb")
    end
  end
end
