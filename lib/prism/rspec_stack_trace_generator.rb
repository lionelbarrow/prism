class RSpecStackTraceGenerator
  def initialize
    @tracer = StackTraceGenerator.new(RSpecFilter)
  end

  def stack_trace(&block)
    @tracer.stack_trace { block.call }
  end
end
