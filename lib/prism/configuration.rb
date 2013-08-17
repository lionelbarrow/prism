module Prism
  class Configuration
    def self.project_root=(root)
      @project_root = root
    end

    def self.diff=(diff)
      @diff = diff
    end

    def self.diff
      @diff
    end

    def self.project_root
      @project_root || raise("You must set a Prism::Configuration.project_root")
    end

    def self.core
      @core ||= Core.new(RSpecStackTraceGenerator.new)
    end
  end
end
