require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Login")
    end
    
    it "should have the right heading" do
      get :new
      response.should have_selector("h1", :content => "Login")
    end

    it "should have the right width" do
      get :new
      response.should have_selector("div.copy", :style => "width:250px")
    end
    
    it "should have a username field" do
      get :new
      response.should have_selector("input[name='session[username]'][type='text']")
    end
    
    it "should have a password field" do
      get :new
      response.should have_selector("input[name='session[password]'][type='password']")
    end
    
  end

  describe "POST 'create'" do
    
    describe "invalid login" do
      before :each do
        @attr = { :username => "johndoe", :password => "invalid" }
      end
      
      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end
      
      it "should have the right title" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "Login")
      end
    
      it "should have the right heading" do
        post :create, :session => @attr
        response.should have_selector("h1", :content => "Login")
      end
  
      it "should have the right width" do
        post :create, :session => @attr
        response.should have_selector("div.copy", :style => "width:250px")
      end
    end
    
    describe "with valid username and password" do
      before :each do
        @user = Factory(:user)
        @attr = { :username => @user.username, :password => @user.password }
      end
      
      it "should log the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_logged_in
      end
      
      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end
    end
    
  end

  describe "DELETE 'destroy'" do
    it "should log a user out" do
      test_login(Factory(:user))
      delete :destroy
      controller.should_not be_logged_in
      response.should redirect_to(root_path)
    end
  end

end
