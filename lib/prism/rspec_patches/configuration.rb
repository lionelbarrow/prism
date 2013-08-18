module RSpec
  module Core
    class Configuration
      add_setting :prism_enabled
      add_setting :prism_diff
      add_setting :prism_project_root

      def prism_project_root=(root)
        @prism_root = root
      end

      def prism_diff=(diff)
        @prism_diff = diff
      end

      def prism_enabled=(enabled)
        raise "You must define a Prism project root and a Prism diff." if @prism_root.nil? || @prism_diff.nil?
        _turn_prism_on if enabled
      end

      def _turn_prism_on
        config = Prism::Configuration.new(@prism_root, @prism_diff)
        World.class_eval do
          define_method(:example_groups) do
            @fegl ||= Prism::ExampleGroupList.new(config, @example_groups).extend(Extensions::Ordered::ExampleGroups)
          end
        end
      end
    end
  end
end
