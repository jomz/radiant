# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../') unless defined? ENGINE_RAILS_ROOT

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end

require 'dataset'
require 'dataset/extensions/rspec'

Dataset::Resolver.default = Dataset::DirectoryResolver.new("#{ENGINE_RAILS_ROOT}/spec/datasets")

def test_helper(*names)
  names.each do |name|
    name = name.to_s
    name = $1 if name =~ /^(.*?)_test_helper$/i
    name = name.singularize
    first_time = true
    begin
      constant = (name.camelize + 'TestHelper').constantize
      self.class_eval { include constant }
    rescue NameError
      filename = File.expand_path(File.dirname(__FILE__) + '/../test/helpers/' + name + '_test_helper.rb')
      require filename if first_time
      first_time = false
      retry
    end
  end
end    
alias :test_helpers :test_helper

class Test::Unit::TestCase
  require 'dataset'
  # require 'dataset/extensions/test_unit'
end
