module RSpec
  module Core
    class Configuration
      add_setting :prism_recording_enabled
      add_setting :prism_trace_file
      add_setting :prism_project_root

      def prism_recording_enabled=(enabled)
        if @prism_root.nil? || @prism_trace_file.nil?
          raise "You must define a Prism project root and a Prism trace file."
        end
        _enable_prism_tracing if enabled
      end

      def prism_trace_file=(file)
        @prism_trace_file = file
      end

      def prism_project_root=(root)
        @prism_root = root
      end

      def _enable_prism_tracing
        runner = Prism::Runner.new(@prism_root)
        World.class_eval do
          define_method(:example_groups) do
            @fegl ||= Prism::ExampleGroupList.new(runner, @example_groups).extend(Extensions::Ordered::ExampleGroups)
          end
        end
        trace_file = @prism_trace_file
        after(:suite) do
          File.open(trace_file, "w") do |f|
            f << Marshal.dump(runner.results)
          end
        end
      end
    end
  end
end
