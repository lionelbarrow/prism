require "test_project"
require "../../lib/prism"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.prism_project_root = "spec/test_project"
  config.prism_trace_file = ".prism"
  config.prism_recording_enabled = true
end
