require "spec_helper"

describe RSpec::Core::Configuration do
  it "adds 'prism_enabled' to RSpec::Core::Configuration" do
    RSpec::Core::Configuration.new.should respond_to(:prism_enabled)
    RSpec::Core::Configuration.new.should respond_to(:prism_enabled=)
  end
end
