module RSpec
  module Core
    class Configuration
      add_setting :prism_enabled
      add_setting :prism_diff
      add_setting :prism_project_root

      def prism_project_root=(root)
        Prism::Configuration.project_root = root
      end
    end
  end
end

module RSpec
  module Core
    class World
      def example_groups
        @fegl ||= FakeExampleGroupList.new(@example_groups).extend(RSpec::Core::Extensions::Ordered::ExampleGroups)
      end
    end
  end
end

class FakeExampleGroup
  def initialize(inner_group)
    @inner_group = inner_group
  end

  def run(reporter)
    Prism::Configuration.core.run_and_save_trace!(@inner_group, reporter)
  end

  def method_missing(method, *args, &block)
    @inner_group.send(method, *args, &block)
  end
end

class FakeExampleGroupList
  include Enumerable

  def initialize(list)
    @inner_list = list.map { |i| FakeExampleGroup.new(i) }
  end

  def each(&block)
    @inner_list.each { |e| block.call(e) }
  end

  def <<(other)
    @inner_list << FakeExampleGroup.new(other)
  end

  def size
    @inner_list.size
  end
end
