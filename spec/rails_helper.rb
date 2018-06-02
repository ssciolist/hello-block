# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start "rails" do
  add_filter "app/channels/application_cable/channel.rb"
  add_filter "app/channels/application_cable/connection.rb"
  add_filter "app/jobs/application_job.rb"
  add_filter "app/helpers/application_helper.rb"
  add_filter "app/models/application_record.rb"
end

require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'webmock/rspec'
WebMock.disable_net_connect!(allow: 'https://maps.googleapis.com')

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

DatabaseCleaner.strategy = :truncation

  RSpec.configure do |c|
    c.before(:each) do
      DatabaseCleaner.clean
    end

    c.after(:each) do
      DatabaseCleaner.clean
    end
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new (
    {
      "provider" => "google_oauth2",
      "uid" => "100000000000000000000",
      "info" => {
        "name" => "John Smith",
        "email" => "john@example.com",
        "first_name" => "John",
        "last_name" => "Smith",
        "image" => "https://lh4.googleusercontent.com/photo.jpg",
        "urls" => {
          "google" => "https://plus.google.com/+JohnSmith"
        }
      },
      "credentials" => {
        "token" => "TOKEN",
        "refresh_token" => "REFRESH_TOKEN",
        "expires_at" => 1496120719,
        "expires" => true
      },
      "extra" => {
        "id_token" => "ID_TOKEN",
        "id_info" => {
          "azp" => "APP_ID",
          "aud" => "APP_ID",
          "sub" => "100000000000000000000",
          "email" => "john@example.com",
          "email_verified" => true,
          "at_hash" => "HK6E_P6Dh8Y93mRNtsDB1Q",
          "iss" => "accounts.google.com",
          "iat" => 1496117119,
          "exp" => 1496120719
        },
        "raw_info" => {
          "kind" => "plus#personOpenIdConnect",
          "gender" => "male",
          "sub" => "100000000000000000000",
          "name" => "John Smith",
          "given_name" => "John",
          "family_name" => "Smith",
          "profile" => "https://plus.google.com/+JohnSmith",
          "picture" => "https://lh4.googleusercontent.com/photo.jpg?sz=50",
          "email" => "john@example.com",
          "email_verified" => "true",
          "locale" => "en",
          "hd" => "company.com"
        }
      }
    }
  )
end



# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

end
