require 'spec_helper'

describe "Users" do
  
  describe "registration" do
    
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit register_path
          fill_in "First name", :with => ""
          fill_in "Last name", :with => ""
          fill_in "Email", :with => ""
          fill_in "Username", :with => ""
          fill_in "Password", :with => ""
          fill_in "Password confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit register_path
          fill_in "First name", :with => "John"
          fill_in "Last name", :with => "Doe"
          fill_in "Email", :with => "johndoe@mailinator.com"
          fill_in "Username", :with => "johndoe"
          fill_in "Password", :with => "foobar"
          fill_in "Password confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success", :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
    
  end
  
end
