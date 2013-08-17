module Prism
  class ExampleGroupWrapper
    def initialize(inner_group)
      @inner_group = inner_group
    end

    def run(reporter)
      Prism::Configuration.core.run_and_save_trace!(@inner_group, reporter)
    end

    def method_missing(method, *args, &block)
      @inner_group.send(method, *args, &block)
    end
  end
end
