require 'spec_helper'

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
end
