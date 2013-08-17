require "spec_helper"

describe RSpec::Core::Configuration do
  it "adds 'prism_enabled' to RSpec::Core::Configuration" do
    RSpec::Core::Configuration.new.should respond_to(:prism_enabled)
    RSpec::Core::Configuration.new.should respond_to(:prism_enabled=)
  end

  it "adds 'prism_diff to RSpec::Core::Configuration" do
    RSpec::Core::Configuration.new.should respond_to(:prism_diff)
    RSpec::Core::Configuration.new.should respond_to(:prism_diff=)
  end

  it "can set the prism project root" do
    old_root = Prism::Configuration.project_root

    RSpec.configure do |config|
      config.prism_project_root = "foo"
    end

    Prism::Configuration.project_root.should == "foo"

    Prism::Configuration.project_root = old_root
  end
end
