# frozen_string_literal: true

require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, { timeout: 10, js_errors: false })
end

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.before(:each, js: true) do
    page.driver.resize(1920, 1080)
  end
end
