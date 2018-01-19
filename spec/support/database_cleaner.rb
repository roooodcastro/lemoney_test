# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion, except: %w[ar_internal_metadata])
  end

  config.before(:each) do |spec|
    DatabaseCleaner.strategy = if spec.metadata[:js]
                                 :deletion
                               else
                                 :transaction
                               end
  end

  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
end
