require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job, time|
    puts "Running #{job}, at #{time}"
    "#{job}".constantize.perform_later
  end

  every(1.hours, 'SyncIvmrsJob') 
  # every(1.hours, 'SyncBvmrJob')


end
