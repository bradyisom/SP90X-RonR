require 'spec_helper'

describe PagesController do
  render_views
  
  before :each do
    @base_title = 'SP90X - '
  end

  describe "GET 'home'" do
    it "should be successful" do
      get :home
      response.should be_success
    end
    
    it "should have the right title" do
      get :home
      response.should have_selector("title", :content => @base_title + 'Home')
    end
    
    it "should have the right header" do
      get :home
      response.should have_selector("h1", :content => 'Welcome')
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get :about
      response.should be_success
    end
    
    it "should have the right title" do
      get :about
      response.should have_selector("title", :content => @base_title + 'About')
    end
    
    it "should have the right header" do
      get :about
      response.should have_selector("h1", :content => 'About')
    end
  end

  describe "GET 'donate'" do
    it "should be successful" do
      get :donate
      response.should be_success
    end
    
    it "should have the right title" do
      get :donate
      response.should have_selector("title", :content => @base_title + 'Donate')
    end
    
    it "should have the right header" do
      get :donate
      response.should have_selector("h1", :content => 'Donate')
    end

    it "should have the donate button" do
      get :donate
      response.should have_selector("form", :action => 'https://www.paypal.com/cgi-bin/webscr')
    end
  end

  describe "GET 'feedback'" do
    it "should be successful" do
      get :feedback
      response.should be_success
    end
    
    it "should have the right title" do
      get :feedback
      response.should have_selector("title", :content => @base_title + 'Feedback')
    end
    
    it "should have the right header" do
      get :feedback
      response.should have_selector("h1", :content => 'Feedback')
    end
  end

  describe "GET 'resources'" do
    it "should be successful" do
      get :resources
      response.should be_success
    end
    
    it "should have the right title" do
      get :resources
      response.should have_selector("title", :content => @base_title + 'Resources')
    end
    
    it "should have the right header" do
      get :resources
      response.should have_selector("h1", :content => 'Resources')
    end
  end

end
