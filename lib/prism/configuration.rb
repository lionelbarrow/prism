module Prism
  class Configuration
    attr_reader :project_root, :diff

    def initialize(project_root, diff)
      @project_root = project_root
      @diff = diff
    end
  end
end
