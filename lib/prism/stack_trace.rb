module Prism
  class StackTrace
    def self.location_of_group(example_group)
      example_group_data = example_group.metadata[:example_group]
      file_path = example_group_data[:file_path]
      matches = /\.\/(\S+)$/.match(file_path)
      file_path = matches.captures.first unless matches.nil?
      "#{file_path}:#{example_group_data[:line_number]}"
    end

    attr_reader :stack_trace, :location

    def initialize(example_group, stack_trace)
      @location = self.class.location_of_group(example_group)
      @stack_trace = stack_trace
    end

    def serialize
      {
        "location" => @location,
        "stack_trace" => @stack_trace.map { |s| s.serialize }
      }
    end
  end
end
