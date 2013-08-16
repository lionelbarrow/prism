require "test_project"
Dir.entries("../../lib/prism").each do |f|
  require "../../lib/prism/#{f}" if f.end_with?(".rb")
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.prism_enabled = true
  config.prism_project_root = "test_project"
end
