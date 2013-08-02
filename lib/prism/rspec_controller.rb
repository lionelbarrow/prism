class RSpecController
  def initialize
    @tracer = RSpecStackTraceGenerator.new
  end

  def files_in_scope_for_group(example_group)
    files = Set.new
    stack_frames = @tracer.stack_trace { example_group.run }
    stack_frames.each do |frame|
      files << frame.file
    end
    files
  end
end
