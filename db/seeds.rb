# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


case Rails.env
  when "development"

    categories = Category.create([{:name => 'Homework'},
                                  {:name => 'Project'},
                                  {:name => 'Quiz'}])

    users = User.create([{:email => 'super_admin@ncsu.edu', :password => '5uperpass', :super_admin => true},
                         {:email => 'admin1@ncsu.edu', :password => 'admin1pass', :admin => true},
                         {:email => 'admin2@ncsu.edu', :password => 'admin2pass', :admin => true},
                         {:email => 'admin3@ncsu.edu', :password => 'admin3pass', :admin => true},
                         {:email => 'user1@ncsu.edu', :password => 'user1pass'},
                         {:email => 'user2@ncsu.edu', :password => 'user2pass'},
                         {:email => 'user3@ncsu.edu', :password => 'user3pass'}])

    posts = Post.create([{:category => categories[0], :user => users[4], :title => 'Deadline for Homework 1', :content => 'What is the deadline for Homework 1?', :tags => 'homework1,deadline', :votes => Vote.create([{:user => users[5]}, {:user => users[6]}])},
                         {:category => categories[1], :user => users[5], :title => 'Tutorial for Webrat', :content => 'Hey, I found this short tutorial for Webrat @ http://railscasts.com/episodes/156-webrat', :tags => 'project1,webrat,tutorial', :votes => Vote.create([{:user => users[4]}])},
                         {:category => categories[2], :user => users[6], :title => 'Scores for Quiz 2', :content => 'I cannot see my scores for Quiz 2 on WebAssign.', :tags => 'scores,quiz2,webassign'}])

    comments = Comment.create([{:post => posts[0], :user => users[6], :votes => Vote.create([{:user => users[4]}]), :content => 'Homework 1 is due on September 30th at 11:59pm.'},
                               {:post => posts[2], :user => users[5], :votes => Vote.create([{:user => users[6]}]), :content => 'I have rectified the problem. Please check again.'}])


  when "production"

    categories = Category.create([{:name => 'Homework'},
                                  {:name => 'Project'},
                                  {:name => 'Quiz'}])

    users = User.create([{:email => 'super_admin@ncsu.edu', :password => '5uperpass', :super_admin => true},
                         {:email => 'admin1@ncsu.edu', :password => 'admin1pass', :admin => true},
                         {:email => 'admin2@ncsu.edu', :password => 'admin2pass', :admin => true},
                         {:email => 'admin3@ncsu.edu', :password => 'admin3pass', :admin => true},
                         {:email => 'user1@ncsu.edu', :password => 'user1pass'},
                         {:email => 'user2@ncsu.edu', :password => 'user2pass'},
                         {:email => 'user3@ncsu.edu', :password => 'user3pass'}])

    posts = Post.create([{:category => categories[0], :user => users[4], :title => 'Deadline for Homework 1', :content => 'What is the deadline for Homework 1?', :tags => 'homework1,deadline', :votes => Vote.create([{:user => users[5]}, {:user => users[6]}])},
                         {:category => categories[1], :user => users[5], :title => 'Tutorial for Webrat', :content => 'Hey, I found this short tutorial for Webrat @ http://railscasts.com/episodes/156-webrat', :tags => 'project1,webrat,tutorial', :votes => Vote.create([{:user => users[4]}])},
                         {:category => categories[2], :user => users[6], :title => 'Scores for Quiz 2', :content => 'I cannot see my scores for Quiz 2 on WebAssign.', :tags => 'scores,quiz2,webassign'}])

    comments = Comment.create([{:post => posts[0], :user => users[6], :votes => Vote.create([{:user => users[4]}]), :content => 'Homework 1 is due on September 30th at 11:59pm.'},
                               {:post => posts[2], :user => users[5], :votes => Vote.create([{:user => users[6]}]), :content => 'I have rectified the problem. Please check again.'}])


end
