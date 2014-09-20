require 'spec_helper'

describe "Categories" do
  it "can be created by an administrator" do
    visit root_path
    fill_in 'user[email]', :with => "admin1@ncsu.edu"
    fill_in 'user[password]', :with => "admin1pass"
    click_button "Sign in"
    visit categories_path
    click_link "New"
    fill_in 'category[name]', :with => "Foobar"
    click_button "Create Category"
    visit categories_path
    assert_contain "Foobar"
  end
  it "can be created by an super admin" do
    visit root_path
    fill_in 'user[email]', :with => "super_admin@ncsu.edu"
    fill_in 'user[password]', :with => "5uperpass"
    click_button "Sign in"
    visit categories_path
    click_link "New"
    fill_in 'category[name]', :with => "Bazqux"
    click_button "Create Category"
    visit categories_path
    assert_contain "Bazqux"
  end
  it "cannot be created by regular user" do
    visit root_path
    fill_in 'user[email]', :with => "user1@ncsu.edu"
    fill_in 'user[password]', :with => "user1pass"
    click_button "Sign in"
    visit categories_path
    assert_contain "You are not authorized to access this page."
  end
end
