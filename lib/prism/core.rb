class Core
  TRACE_MAP_FILE = ".prism"

  def initialize(tracer)
    @tracer = tracer
    _save_to_trace_map_file({}) unless File.exists?(TRACE_MAP_FILE)
  end

  def run_and_save_trace!(example_group)
    stack_trace = stack_trace_for_group(example_group)
    new_trace_map = _readonly_trace_map
    new_trace_map[stack_trace.location] = stack_trace
    _save_to_trace_map_file(new_trace_map)
  end

  def get_saved_trace(example_group)
    location = RSpecStackTrace.location_of_group(example_group)
    _readonly_trace_map[location]
  end

  def stack_trace_for_group(example_group)
    stack_frames = @tracer.stack_trace { example_group.run }
    RSpecStackTrace.new(example_group, stack_frames)
  end

  def files_in_scope_for_diff(diff)
    Set.new(DiffParser.affected_files(diff))
  end

  def _readonly_trace_map
    @trace_map ||= File.open(TRACE_MAP_FILE, "r") { |f| Marshal.load(f.read) }
  end

  def _save_to_trace_map_file(trace_map)
    File.open(TRACE_MAP_FILE, "w") { |f| f << Marshal.dump(trace_map) }
  end
end