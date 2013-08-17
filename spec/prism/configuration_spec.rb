require "spec_helper"

describe Prism::Configuration do
  describe "project_root" do
    it "raises an exception if the path root is not set" do
      Prism::Configuration.project_root = nil
      expect { Prism::Configuration.project_root }.to raise_error
      Prism::Configuration.project_root = "prism"
    end
  end
end
