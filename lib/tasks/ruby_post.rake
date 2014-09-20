namespace :ruby_post do
  desc "Run Unit tests for RubyPost"
  task :unit_tests do
    Rails.env = "test"
    ENV['SPEC'] = 'spec/models/*'
    Rake::Task['spec'].invoke
  end
  desc "Run Functional tests for RubyPost"
  task :functional_tests do
    Rails.env = "test"
    ENV['SPEC'] = 'spec/controllers/*'
    Rake::Task['spec'].invoke
  end
  desc "Run Integration tests for RubyPost"
  task :integration_tests do
    Rails.env = "development"
    Rake::Task['db:reset'].invoke
    ENV['SPEC'] = 'spec/requests/*'
    Rake::Task['spec'].invoke
  end
end