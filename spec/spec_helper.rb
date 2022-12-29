require 'pry'
require_relative '../lib/bible_parser'

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.order = 'random'
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  def fixture_path(filename)
    File.expand_path("../fixtures/#{filename}", __FILE__)
  end
end
