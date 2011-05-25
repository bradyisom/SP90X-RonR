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
  
  it "should have the right links on the site header" do
    visit root_path
    
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Feedback"
    response.should have_selector('title', :content => "Feedback")
    click_link "Donate"
    response.should have_selector('title', :content => "Donate")
    click_link "Resources"
    response.should have_selector('title', :content => "Resources")
    click_link "Login"
    response.should have_selector('title', :content => "Login")
    click_link "Register"
    response.should have_selector('title', :content => "Register")
  end
end
