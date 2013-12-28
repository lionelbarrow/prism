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

class TestReader
  def read
    ""
  end
end

class TestWriter
  def initialize
    @writes = []
  end

  def <<(arg)
    @writes << arg
  end

  def read
    @writes.join("")
  end
end
