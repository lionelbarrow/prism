class RSpecStackTraceGenerator
  def initialize
    @tracer = StackTraceGenerator.new
  end

  def stack_trace(&block)
    @tracer.stack_trace { block.call }
  end
end
