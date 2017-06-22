$: << "."
$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), ".."))

require 'rubygems'
require 'selenium-webdriver'
require 'selenium/server'
require 'capybara'
require "capybara/selenium/driver"
require 'capybara/cucumber'
require 'site_prism'
require 'rspec'
require 'rspec/expectations'
require 'rspec/matchers'
require 'capybara/rspec'
require 'cucumber'
require 'report_builder'
require 'net/http'
require "support/formatters/logger"

##instantiate the logger
$logger = Loggers::CliLogger

##Initailising the headless driver as default
driver_name = :Poltergeist
driver_name = ENV["DRIVER"].capitalize.to_sym if !ENV["DRIVER"].nil?

##Configuring Capybara webdriver
Capybara.configure do |config|
  $logger.info "Configuring #{driver_name} driver"
  config.default_driver = driver_name
  config.javascript_driver = driver_name
  config.run_server = false
  config.default_wait_time = 60
  Capybara.javascript_driver = :chrome if driver_name != :Poltergeist
end

##Registering Capybara webdriver
Capybara.register_driver driver_name do |app|
  if driver_name.eql?(:Poltergeist)
    $logger.info "Instantiating #{driver_name} driver"
    options = {
        js_errors:  false,
        debug:  false,
        inspector: true,
        timeout:  200,
        phantomjs_options: ["--ignore-ssl-errors=yes"]
    }
    Capybara::Poltergeist::Driver.new(app, options)
  else
    $logger.info "Instantiating #{driver_name} driver"
    args = ["--window-size=2000,2000", "--test-type", "--silent", "--ignore-certifcate-errors"]
    prefs = {
        download: {
            prompt_for_download: false,
            default_directory: $download_files_path.to_s,
            default_wait_time: 60
        }
    }
    Selenium::WebDriver::Chrome::Service.executable_path = Dir.getwd + "/chromedriver"
    Capybara::Selenium::Driver.new(app, browser: :chrome, args: args, prefs: prefs)
  end
end

##get the current path of the file
path = File.join(File.dirname(__FILE__), "..", "..")

##get environment run details
$envConfig = YAML.load(File.read(path + "/config/environment.yml"))
PLR_ENV = $envConfig[:url][ENV["RUN_AGAINST"].to_sym]
$logger.info "Host URL is ----> #{PLR_ENV.inspect}"


##get user details from users.yml file
$userConfig = YAML.load(File.read(path + "/config/users.yml"))



