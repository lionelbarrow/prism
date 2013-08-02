class RSpecFilter
  def self.allow?(frame)
    _classname_ok?(frame) && _file_is_not_in_rspec(frame)
  end

  def self._classname_ok?(frame)
    frame.classname.nil? || _is_not_from_rspec_core_configuration_class(frame)
  end

  def self._is_not_from_rspec_core_configuration_class(frame)
    frame.classname.to_s[/RSpec::Core::Configuration/].nil?
  end

  def self._file_is_not_in_rspec(frame)
    frame.file[/rspec-core/].nil? && frame.file[/rspec-mocks/].nil? && frame.file[/rspec-expectations/].nil?
  end
end
