class StackFrame
  attr_reader :event, :file, :line, :id, :binding, :classname

  def initialize(event, file, line, id, binding, classname)
     @event = event
     @file = file
     @line = line
     @id = id
     @binding = binding
     @classname = classname
  end

  def to_s
    sprintf("%8s %s:%-2d %10s %8s", event, file, line, id, classname)
  end
end
