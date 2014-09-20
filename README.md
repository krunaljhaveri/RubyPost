RubyPost
========

Team:
    Name                            Unity ID
    Jitendra Bangani                jtbangan
    Aniket Sonmale                  amsonmal
    Krunal Jhaveri                  knjhaver


Test frameworks:
    Test                            Framework       Command
    Unit tests                      RSpec           rake ruby_post:unit_tests
    Functional tests                RSpec           rake ruby_post:functional_tests
    Integration tests               Webrat          rake ruby_post:integration_tests


URL and Seed data for application:
    http://152.46.18.178/

    Email                   Password        Role
    user1@ncsu.edu          user1pass       user
    admin1@ncsu.edu         admin1pass      admin
    super_admin@ncsu.edu    5uperpass       super admin


Setup steps:
    Windows Environment
        1. Setup your environment using RailsInstaller
        2. Download and Extract the project ZIP file
        3. Copy RubyPost/dep/lib/v8.dll to C:\Windows\v8.dll
        4. Start command prompt and navigate to RubyPost directory
        5. Run the following commands:
            bundle install
            rake db:reset RAILS_ENV=production
            rails server -b 0.0.0.0 -p 80 -e production

Extra credit features:
    1. Use of RSpec instead of Test::Unit for Unit and Functional tests
    2. Use of Webrat for Integration tests
    3. Use of fixtures instead of seeded data for running tests
    4. Deployed on both VCL and Heroku environments successfully
    5. Implemented Bootstrap for a rich user experience
    6. Used NCSU's Enterprise GitHub for source control
    7. Implemented Polymorphic associations for Votes http://guides.rubyonrails.org/association_basics.html#polymorphic-associations
    8. Custom Rake tasks for running unit (ruby_post:unit_tests), functional (ruby_post:functional_tests) and integration tests (ruby_post:integration_tests)