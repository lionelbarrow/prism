require "spec_helper"

describe RSpec::Core::Configuration do
  it "adds 'prism_recording_enabled' to RSpec::Core::Configuration" do
    RSpec::Core::Configuration.new.should respond_to(:prism_recording_enabled=)
  end

  it "adds 'prism_project_root' to RSpec::Core::Configuration" do
    RSpec::Core::Configuration.new.should respond_to(:prism_project_root=)
  end
end
