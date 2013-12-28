module Prism
  class RSpecStackTrace
    def self.location_of_group(example_group)
      example_group_data = example_group.metadata[:example_group]
      file_path = example_group_data[:file_path]
      matches = /\.\/(\S+)$/.match(file_path)
      file_path = matches.captures.first unless matches.nil?
      "#{file_path}:#{example_group_data[:line_number]}"
    end

    attr_reader :file_set, :location

    def initialize(example_group, stack_trace)
      @location = self.class.location_of_group(example_group)
      @file_set = Set.new(stack_trace.map { |event| event.filename })
    end

    def ==(other)
      @location == other.location && @file_set == other.file_set
    end
  end
end
