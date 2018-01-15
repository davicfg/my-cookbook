include Warden::Test::Helpers
require 'devise'
RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.use_transactional_fixtures = false
end