begin
  require 'bundler/setup'
end

DUMMY_RAKEFILE = File.expand_path('../spec/dummy/Rakefile', __FILE__)


# Dir["#{RADIANT_ROOT}/lib/tasks/**/*.rake"].sort.each { |taskfile| load taskfile }
# Radiant::ExtensionPath.rake_task_paths.each { |taskfile| load taskfile }

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

Bundler::GemHelper.install_tasks