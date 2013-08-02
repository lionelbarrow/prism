class StackFrame
  attr_reader :event, :line, :id, :binding, :classname

  def initialize(event, file, line, id, binding, classname)
     @event = event
     @file = file
     @line = line
     @id = id
     @binding = binding
     @classname = classname
  end

  def file
    "#{Prism::Configuration.path_root}#{@file.split(Prism::Configuration.path_root)[-1]}"
  end

  def to_s
    sprintf("%8s %s:%-2d %10s %8s", event, file, line, id, classname)
  end
end
