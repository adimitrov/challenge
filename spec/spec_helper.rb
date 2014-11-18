require 'fakeweb'
require 'vcr'
require 'support/vcr'
require 'stackexchange/client'
require 'wolfram/client'

RSpec.configure do |config|
  config.formatter = 'documentation'
  config.order = 'random'
  config.fail_fast = true
end
