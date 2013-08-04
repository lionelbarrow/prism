class Core
  def initialize(tracer)
    @tracer = tracer
  end

  def files_in_scope_for_group(example_group)
    files = Set.new
    stack_frames = @tracer.stack_trace { example_group.run }
    stack_frames.each do |frame|
      files << frame.file
    end
    files
  end

  def files_in_scope_for_diff(diff)
    Set.new(DiffParser.affected_files(diff))
  end

  def run_and_save_trace!(example_group)
  end

  def get_saved_trace(example_group)
  end
end
