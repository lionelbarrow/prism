module Prism
  class StackFrame
    attr_reader :event, :line, :id, :binding, :classname

    def initialize(config, event, file, line, id, binding, classname)
      @config = config
      @event = event
      @file = file
      @line = line
      @id = id
      @binding = binding
      @classname = classname
    end

    def file
      matches = /#{@config.project_root}\/(\S+)$/.match(@file)
        return @file if matches.nil?
      matches.captures.first
    end

    def to_s
      sprintf("%8s %s:%-2d %10s %8s", event, file, line, id, classname)
    end
  end
end
