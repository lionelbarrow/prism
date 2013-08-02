class PrismFilter
  BLACKLISTED_CLASSNAMES = Set.new(["StackTraceGenerator", "RSpecController", "RSpecStackTraceGenerator"])

  def self.allow?(frame)
    _classname_ok?(frame) && _file_is_not_in_prism_gem(frame)
  end

  def self._classname_ok?(frame)
    frame.classname.nil? || ! BLACKLISTED_CLASSNAMES.include?(frame.classname.to_s)
  end

  def self._file_is_not_in_prism_gem(frame)
    frame.file[/stack_trace_generator/].nil?
  end
end
