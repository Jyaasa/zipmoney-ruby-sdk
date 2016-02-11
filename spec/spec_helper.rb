require 'rubygems'
require 'bundler/setup'

require 'zipMoney' # and any other gems you need

RSpec.configure do |config|
  	config.expect_with :rspec do |expect|
        expect.syntax = [:should, :expect]
    end
end
