require_relative '../lib/bible_xml'

RSpec.configure do |config|
  config.mock_with :rspec
  config.color = true
  config.order = 'random'
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  def tmp_path
    File.expand_path('../../tmp', __FILE__)
  end
end
