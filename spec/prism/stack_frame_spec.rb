require "spec_helper"

describe Prism::StackFrame do
  describe "filename" do
    it "only includes file paths after the Prism::Configuration.project_root" do
      frame = Prism::StackFrame.new("prism", "c-call", "/Users/lionel/prism/spec/spec_helper.rb", 5, nil, nil, nil)

      frame.filename.should == "spec/spec_helper.rb"
    end

    it "includes file paths after the first occurance of the path root" do
      frame = Prism::StackFrame.new("prism", "c-call", "/Users/lionel/prism/spec/prism/core_spec.rb", 5, nil, nil, nil)

      frame.filename.should == "spec/prism/core_spec.rb"
    end
  end
end
