#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

ENGINE_PATH = File.dirname(__FILE__)
APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

if File.exists?(APP_RAKEFILE)
  load 'rails/tasks/engine.rake'
end

require "refinerycms-testing"
Refinery::Testing::Railtie.load_tasks
Refinery::Testing::Railtie.load_dummy_tasks(ENGINE_PATH)

load File.expand_path('../tasks/testing.rake', __FILE__)
load File.expand_path('../tasks/rspec.rake', __FILE__)

task :default do

  ENV['RAILS_ENV'] ||= 'test'
  new_dumy_app = File.exists? File.expand_path('../spec/dummy', __FILE__)
  unless new_dumy_app
    puts "Dummy app not found"
    Rake::Task['refinery:testing:dummy_app'].invoke
    Dir.chdir  File.expand_path("..", __FILE__)
  end

  Rake::Task['spec'].invoke

  Rake::Task['refinery:testing:clean_dummy_app'].invoke unless new_dumy_app

end
