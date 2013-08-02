require "spec_helper"

describe Prism::Configuration do
  describe "path_root" do
    it "raises an exception if the path root is not set" do
      Prism::Configuration.path_root = nil
      expect { Prism::Configuration.path_root }.to raise_error
      Prism::Configuration.path_root = "prism"
    end
  end
end
