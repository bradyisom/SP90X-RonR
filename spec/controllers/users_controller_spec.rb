require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Register")
    end
    
    it "should have the right heading" do
      get :new
      response.should have_selector("h1", :content => "Register")
    end
    
    it "should have a first name field" do
      get :new
      response.should have_selector("input[name='user[first_name]'][type='text']")
    end
    
    it "should have a last name field" do
      get :new
      response.should have_selector("input[name='user[last_name]'][type='text']")
    end
    
    it "should have an email field" do
      get :new
      response.should have_selector("input[name='user[email]'][type='text']")
    end
    
    it "should have a username field" do
      get :new
      response.should have_selector("input[name='user[username]'][type='text']")
    end
    
    it "should have a password field" do
      get :new
      response.should have_selector("input[name='user[password]'][type='password']")
    end
    
    it "should have a password confirmation field" do
      get :new
      response.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
    
    it "should have a male radio button" do
      get :new
      response.should have_selector("input[name='user[gender]'][type='radio'][value='M']")
    end
    it "should have a female radio button" do
      get :new
      response.should have_selector("input[name='user[gender]'][type='radio'][value='F']")
    end
    
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      before :each do
        @attr = {
          :first_name => '',
          :last_name => '',
          :email => '',
          :username => '',
          :gender => '',
          :password => '',
          :password_confirmation => ''
        } 
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Register")
      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template("new")
      end
      
    end
    
    describe "success" do
      before :each do
        @attr = {
          :first_name => 'John',
          :last_name => 'Doe',
          :email => 'foo@bar.com',
          :username => 'jdoe',
          :gender => 'M',
          :password => 'password',
          :password_confirmation => 'password'
        } 
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user detail page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to sp90x/i
      end
    end
    
  end

end
