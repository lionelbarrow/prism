require "spec_helper"

describe StackFrame do
  describe "file" do
    it "only includes file paths after the Prism::Configuration.project_root" do
      Prism::Configuration.project_root = "prism"

      frame = StackFrame.new("c-call", "/Users/lionel/prism/spec/spec_helper.rb", 5, nil, nil, nil)

      frame.file.should == "spec/spec_helper.rb"
    end

    it "includes file paths after the first occurance of the path root" do
      Prism::Configuration.project_root = "prism"

      frame = StackFrame.new("c-call", "/Users/lionel/prism/spec/prism/core_spec.rb", 5, nil, nil, nil)

      frame.file.should == "spec/prism/core_spec.rb"
    end
  end
end
