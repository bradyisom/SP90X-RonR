require 'spec_helper'
require 'digest'

describe User do
  
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
  
  it "should create a new instance with valid attributes" do
    User.create!(@attr)    
  end
  
  describe "attributes" do
    before :each do
      @user = User.create!(@attr)
    end
    
    it "should have a first name attribute" do
      @user.should respond_to(:first_name)
    end
    it "should have a last name attribute" do
      @user.should respond_to(:last_name)
    end
    it "should have a username attribute" do
      @user.should respond_to(:username)
    end
    it "should have an email attribute" do
      @user.should respond_to(:email)
    end
    it "should have a gender attribute" do
      @user.should respond_to(:gender)
    end
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end
    it "should have a password_confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
  end

  describe "validations" do
    
    def test_invalid (merge)
        invalid = @attr.merge( merge )
        user = User.new(invalid)
        user.should_not be_valid
    end
    def test_valid (merge)
        valid = @attr.merge( merge )
        user = User.new(valid)
        user.should be_valid
    end
    
    describe "required fields" do
      it "should require a first_name" do
        test_invalid( {:first_name => nil })
      end
      
      it "should require a last_name" do
        test_invalid( {:last_name => nil })
      end
      
      it "should require an email" do
        test_invalid( {:email => nil })
      end
      
      it "should require a username" do
        test_invalid( {:username => nil })
      end
      
      it "should require a gender" do
        test_invalid( {:gender => nil })
      end
      
      it "should require a password" do
        test_invalid( {:password => nil })
      end
      
      it "should require a password confirmation" do
        test_invalid( { :password_confirmation => '' })
      end
    end
    
    describe "field lengths" do
      it "should not allow first_name > 25" do
        test_valid( { :first_name => 'a' * 25 })
        test_invalid( { :first_name => 'a' * 26 })
      end
      it "should not allow last_name > 25" do
        test_valid( { :last_name => 'a' * 25 })
        test_invalid( { :last_name => 'a' * 26 })
      end
      it "should not allow username > 25" do
        test_valid( { :username => 'a' * 25 })
        test_invalid( { :username => 'a' * 26 })
      end
      it "should not allow email > 50" do
        test_valid( { :email => ('a' * 42) + '@foo.com' })
        test_invalid( { :email => ('a' * 43) + '@foo.com' })
      end
      it "should not allow password < 6" do
        invalid = 'a' * 5;
        test_invalid( { :password => invalid, :password_confirmation => invalid })
      end
      it "should not allow password > 40" do
        invalid = 'a' * 41;
        test_invalid( { :password => invalid, :password_confirmation => invalid })
      end
    end
    
    it "should only allow M and F for gender" do
      test_valid( {:gender => 'M' })
      test_valid( {:gender => 'F' })
      test_invalid( {:gender => 'm' })
      test_invalid( {:gender => 'f' })
      test_invalid( {:gender => 'A' })
    end
    
    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end
  
    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end    
    
    it "should reject duplicate usernames" do
      User.create!(@attr)
      dup = User.new(@attr)
      dup.should_not be_valid
    end
    
    it "should reject duplicate case insensitive usernames" do
      User.create!(@attr)
      test_invalid({ :username => 'JDOE' })
    end
    
    it "should reject entries with mismatching passwords" do
      test_invalid({ :password_confirmation => 'invalid' })
    end
    
  end
  
  describe "password encryption" do
    before :each do
      @user = User.create!(@attr)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end

    describe "authenticate method" do
      it "should return nil on username/password mismatch" do
        invalid = User.authenticate(@attr[:username], "wrongpass")
        invalid.should be_nil
      end
      
      it "should return nil for a non-existing username" do
        invalid = User.authenticate("foobar", @attr[:password])
        invalid.should be_nil        
      end
      
      it "should return the user on username/password match" do
        valid = User.authenticate(@attr[:username], @attr[:password])
        valid.should == @user
      end      
    end
    
  end
    
  describe "upgrade from md5 password" do
    before :each do
      @md5Password = Digest::MD5.hexdigest(@attr[:password])
      ActiveRecord::Base.connection.insert("INSERT into users 
            (id, first_name, last_name, username, gender, email, encrypted_password) 
            VALUES (999, 'John', 'Doe', 'jdoeold', 'M', 'jdoe@foo.com', '" + 
              @md5Password + 
            "')")
      @user = User.find(999)
    end
    
    it "should not upgrade an old_password when not correct" do
      @user.salt.should be_blank
      @user.has_password?("invalid").should be_false
      @user.salt.should be_blank
      @user.encrypted_password.should == @md5Password
    end
    
    it "should upgrade an old password when correct" do
      @user.salt.should be_blank
      @user.has_password?(@attr[:password]).should be_true
      @user.salt.should_not be_blank
      @user.has_password?(@attr[:password]).should be_true
      
      @user = User.find(999)
      @user.salt.should_not be_blank
      @user.has_password?(@attr[:password]).should be_true
    end
  end
end
