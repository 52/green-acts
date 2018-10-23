RSpec.configure do |config|
  config.before :example, type: :system do
    driven_by :rack_test
  end

  config.before :example, type: :system, js: true do
    driven_by :selenium_chrome_headless
  end
end
