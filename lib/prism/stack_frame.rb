module Prism
  class StackFrame
    attr_reader :event, :line, :filename, :id, :binding, :classname

    def initialize(project_root, event, filename, line, id, binding, classname)
      @project_root = project_root
      @event = event
      @line = line
      @id = id
      @binding = binding
      @classname = classname

      matches = /#{@project_root}\/(\S+)$/.match(filename)
      if matches.nil?
        @filename = filename
      else
        @filename = matches.captures.first
      end
    end

    def to_s
      sprintf("%8s %s:%-2d %10s %8s", event, file, line, id, classname)
    end
  end
end
