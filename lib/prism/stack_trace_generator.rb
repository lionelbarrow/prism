class StackTraceGenerator
  attr_reader :stack_frames, :filters

  def initialize(*filters)
    @stack_frames = []
    @filters = []
    filters.each { |f| @filters << f }
  end

  def enable!
    set_trace_func(_stack_frame_recorder)
  end

  def disable!
    set_trace_func(nil)
  end

  def stack_trace(&block)
    enable!
    block.call
    disable!
    @stack_frames
  end

  def _stack_frame_recorder
    Proc.new do |event, file, line, id, binding, classname|
      begin
        qualified_event = StackFrame.new(event, file, line, id, binding, classname)
        @stack_frames << qualified_event if @filters.all? { |f| f.allow?(qualified_event) }
      rescue Exception => e
        puts "Stack frame recorder blew up"
        puts e.message
        puts e.backtrace.inspect
      end
    end
  end
end
