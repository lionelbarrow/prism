module Prism
  class Runner
    attr_reader :results

    def initialize(project_root)
      @project_root = project_root
      @results = {}
      @tracer = StackTraceGenerator.new(project_root, PrismFilter, RSpecFilter)
    end

    def run_group!(example_group, reporter)
      stack_trace = _stack_trace_for_group(example_group, reporter)
      results[stack_trace.location] = stack_trace
    end

    def _stack_trace_for_group(example_group, reporter)
      stack_frames = @tracer.stack_trace { example_group.run(reporter) }
      RSpecStackTrace.new(example_group, stack_frames)
    end
  end
end
