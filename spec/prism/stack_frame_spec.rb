require "spec_helper"

describe StackFrame do
  describe "file" do
    it "only includes file paths after the Prism::Configuration.path_root" do
      Prism::Configuration.path_root = "prism"

      frame = StackFrame.new("c-call", "/Users/lionel/prism/spec/spec_helper.rb", 5, nil, nil, nil)

      frame.file.should == "prism/spec/spec_helper.rb"
    end
  end
end
