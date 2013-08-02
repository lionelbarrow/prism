class PrismFilter
  def self.allow?(frame)
    _classname_ok?(frame) && _file_is_not_in_prism_gem(frame)
  end

  def self._classname_ok?(frame)
    frame.classname.nil? || _is_not_from_stack_trace_generator_class(frame)
  end

  def self._is_not_from_stack_trace_generator_class(frame)
    frame.classname.to_s[/StackTraceGenerator/].nil?
  end

  def self._file_is_not_in_prism_gem(frame)
    frame.file[/stack_trace_generator/].nil?
  end
end
