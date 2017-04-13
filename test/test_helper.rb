# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
require "rails/test_help"

# Models:
# require File.expand_path('../data/models', __FILE__)  

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

Rails::TestUnitReporter.executable = 'bin/test'

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../dummy/test/fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end


class ActiveSupport::TestCase

  def assert_has_one(model, other)
    assert_association(model, :has_one, other)
  end

  def assert_has_many(model, other)
    assert_association(model, :has_many, other)
  end

  def assert_belongs_to(model, other)
    assert_association(model, :belongs_to, other)
  end

  def assert_association(model, type, other)
    assert model.reflect_on_all_associations(type).any? { |a| a.name == other }
  end

end
