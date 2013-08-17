module RSpec
  module Core
    class Configuration
      add_setting :prism_enabled
      add_setting :prism_diff
      add_setting :prism_project_root

      def prism_project_root=(root)
        Prism::Configuration.project_root = root
      end

      def prism_enabled=(enabled)
        _turn_prism_on if enabled
      end

      def _turn_prism_on
        World.class_eval do
          define_method(:example_groups) do
            @fegl ||= ExampleGroupList.new(@example_groups).extend(Extensions::Ordered::ExampleGroups)
          end
        end
      end
    end
  end
end
