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
      
      it "should log the user in" do
        post :create, :user => @attr
        controller.should be_logged_in
      end
    end
    
  end
  
  describe "GET 'show'" do
    before :each do
      @user = Factory(:user)
      test_login(@user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => "#{@user.first_name} #{@user.last_name}")
    end
    
    it "should have the right heading" do
      get :show, :id => @user
      response.should have_selector("h1", :content => "#{@user.first_name} #{@user.last_name}")
    end
  end
  
  describe "GET 'edit'" do
    before :each do
      @user = Factory(:user)
      test_login(@user)
    end
    
    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit Profile")
    end
    
    it "should have the right heading" do
      get :edit, :id => @user
      response.should have_selector("h1", :content => "Edit Profile - #{@user.first_name} #{@user.last_name}")
    end

    it "should have a first name field" do
      get :edit, :id => @user
      response.should have_selector("input[name='user[first_name]'][type='text']")
    end
    
    it "should have a last name field" do
      get :edit, :id => @user
      response.should have_selector("input[name='user[last_name]'][type='text']")
    end
    
    it "should have an email field" do
      get :edit, :id => @user
      response.should have_selector("input[name='user[email]'][type='text']")
    end
    
    it "should have a readonly username field" do
      get :edit, :id => @user
      response.should have_selector("input[name='user[username]'][type='text'][readonly='readonly']")
    end
    
    it "should have a password field" do
      get :edit, :id => @user
      response.should have_selector("input[name='user[password]'][type='password']")
    end
    
    it "should have a password confirmation field" do
      get :edit, :id => @user
      response.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
    
    it "should have a male radio button" do
      get :edit, :id => @user
      response.should have_selector("input[name='user[gender]'][type='radio'][value='M']")
    end
    it "should have a female radio button" do
      get :edit, :id => @user
      response.should have_selector("input[name='user[gender]'][type='radio'][value='F']")
    end
  end
  
  describe "PUT 'update'" do
    before :each do
      @user = Factory(:user)
      test_login(@user)
    end
    
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
      
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edit Profile")
      end
      
      it "should have the right heading" do
        put :update, :id => @user, :user => @attr
        @user.reload
        response.should have_selector("h1", :content => "Edit Profile - #{@user.display_name}")
      end
    end
    
    describe "success" do
      before :each do
        @attr = {
          :first_name => 'Jane',
          :last_name => 'Door',
          :email => 'user@example.com',
          :username => 'jdoe',
          :gender => 'F',
          :password => 'newpassword',
          :password_confirmation => 'newpassword'
        } 
      end
      
      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.first_name.should == @attr[:first_name]
        @user.last_name.should == @attr[:last_name]
        @user.email.should == @attr[:email]
        @user.gender.should == @attr[:gender]
      end
      
      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end
    end
    
  end
  
  describe "authentication of user pages" do
    before :each do
      @user = Factory(:user)
    end
    
    describe "for non-logged-in users" do
      it "should deny access to 'show'" do
        get :show, :id => @user
        response.should redirect_to(login_path)
      end
      
      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(login_path)
      end
      
      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(login_path)
      end
    end
    
    describe "for logged-in users" do
      before :each do
        wrong_user = Factory(:user, :username => "wronguser")
        test_login(wrong_user)
      end
            
      it "should require matching users for 'show'" do
        get :show, :id => @user
        response.should redirect_to(root_path)
      end
      
      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end
      
      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end
    end
  end

end
