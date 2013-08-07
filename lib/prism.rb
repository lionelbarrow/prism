require "prism/version"
require "prism/stack_frame"
require "prism/prism_filter"
require "prism/stack_trace_generator"
require "prism/diff_parser"
require "prism/rspec_stack_trace_generator"
require "prism/rspec_stack_trace"
require "prism/core"
require "prism/rspec_filter"

require "set"

module Prism
  class Configuration
    def self.path_root=(root)
      @path_root = root
    end

    def self.path_root
      @path_root || raise("You must set a Prism::Configuration.path_root")
    end
  end
end
