module Prism
  class ExampleGroupWrapper
    def initialize(prism_core, inner_group)
      @p = prism_core
      @inner_group = inner_group
    end

    def run(reporter)
      @p.run_group!(@inner_group, reporter)
    end

    def method_missing(method, *args, &block)
      @inner_group.send(method, *args, &block)
    end
  end
end
