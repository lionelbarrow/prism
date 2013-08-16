require "prism"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

class TestClass
  def invoke_a_method
  end

  def invoke_bad_method
  end
end

class BadFilter
  def self.allow?(frame)
    if frame.id.nil?
      true
    else
      frame.id[/invoke_bad_method/].nil?
    end
  end
end


class NullObject
  def method_missing(method, *args, &block)
  end
end

def stub_rspec_example_groups
  class << RSpec::Core::ExampleGroup; self; end.class_eval do
    alias_method :original_run, :run

    def run
      original_run(NullObject.new)
    end
  end
end

def restore_rspec_example_groups
  class << RSpec::Core::ExampleGroup; self; end.class_eval do
    remove_method :run
    alias_method :run, :original_run
    remove_method :original_run
  end
end

Prism::Configuration.project_root = "prism"
