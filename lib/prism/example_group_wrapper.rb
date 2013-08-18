module Prism
  class ExampleGroupWrapper
    def initialize(prism_config, inner_group)
      @config = prism_config
      @inner_group = inner_group
    end

    def run(reporter)
      @config.core.run_and_save_trace!(@inner_group, reporter)
    end

    def method_missing(method, *args, &block)
      @inner_group.send(method, *args, &block)
    end
  end
end
