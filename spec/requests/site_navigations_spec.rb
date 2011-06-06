require 'spec_helper'

describe "SiteNavigations" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Feedback page at '/feedback'" do
    get '/feedback'
    response.should have_selector('title', :content => "Feedback")
  end

  it "should have a Donate page at '/donate'" do
    get '/donate'
    response.should have_selector('title', :content => "Donate")
  end

  it "should have a Resources page at '/resources'" do
    get '/resources'
    response.should have_selector('title', :content => "Resources")
  end
  
  it "should have a Login page at '/login'" do
    get '/login'
    response.should have_selector('title', :content => "Login")
  end
  
  it "should have a Register page at '/register'" do
    get '/register'
    response.should have_selector('title', :content => "Register")
  end

  describe "when not logged in" do
    it "should have correct navigation links" do
      visit root_path
      response.should have_selector("a", :href => about_path, :content => "About")
      response.should have_selector("a", :href => feedback_path, :content => "Feedback")
      response.should have_selector("a", :href => donate_path, :content => "Donate")
      response.should have_selector("a", :href => login_path, :content => "Login")
      response.should have_selector("a", :href => register_path, :content => "Register")
    end
    
    it "should have working navigation links" do
      visit root_path
      
      click_link "About"
      response.should have_selector('title', :content => "About")
      click_link "Feedback"
      response.should have_selector('title', :content => "Feedback")
      click_link "Donate"
      response.should have_selector('title', :content => "Donate")
      click_link "Login"
      response.should have_selector('title', :content => "Login")
      click_link "Register"
      response.should have_selector('title', :content => "Register")
    end
  end

  describe "when logged in" do
    before :each do
      @user = Factory(:user)
      integration_login(@user)
    end
    
    it "should have correct navigation links" do
      visit root_path
      response.should have_selector("a", :href => about_path, :content => "About")
      response.should have_selector("a", :href => feedback_path, :content => "Feedback")
      response.should have_selector("a", :href => donate_path, :content => "Donate")
      response.should have_selector("a", :href => resources_path, :content => "Resources")
      response.should have_selector("a", :href => user_path(@user), :content => "#{@user.first_name} #{@user.last_name}")
      response.should have_selector("a", :href => logout_path, :content => "Logout")
    end
    
    it "should have working navigation links" do
      visit root_path
      
      click_link "About"
      response.should have_selector('title', :content => "About")
      click_link "Feedback"
      response.should have_selector('title', :content => "Feedback")
      click_link "Donate"
      response.should have_selector('title', :content => "Donate")
      
      #TODO: Add tests for profile and logout
    end
  end
end
