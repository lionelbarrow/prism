module Prism
  class StackFrame
    attr_reader :event, :line, :id, :binding, :classname

    def initialize(project_root, event, file, line, id, binding, classname)
      @project_root = project_root
      @event = event
      @file = file
      @line = line
      @id = id
      @binding = binding
      @classname = classname
    end

    def file
      matches = /#{@project_root}\/(\S+)$/.match(@file)
        return @file if matches.nil?
      matches.captures.first
    end

    def to_s
      sprintf("%8s %s:%-2d %10s %8s", event, file, line, id, classname)
    end
  end
end
