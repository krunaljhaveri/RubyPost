require 'spec_helper'

describe "Posts" do
  it "can be viewed by a guest" do
    visit root_path
    click_link "Scores for Quiz 2"
    assert_contain "I have rectified the problem. Please check again."
  end
  it "cannot be created by a guest" do
    visit root_path
    assert_not_contain "New Post"
  end
  it "can be created by an user" do
    visit root_path
    fill_in 'user[email]', :with => "user1@ncsu.edu"
    fill_in 'user[password]', :with => "user1pass"
    click_button "Sign in"
    click_link "New Post"
    select "Homework", :from => "post[category_id]"
    fill_in "post[title]", :with => "Test post title"
    fill_in "post[content]", :with => "Test post content"
    click_button "Create Post"
    assert_contain "Test post title"
  end
end
