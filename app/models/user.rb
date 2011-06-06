# == Schema Information
# Schema version: 20110523183716
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  first_name         :string(25)
#  last_name          :string(25)
#  username           :string(25)
#  encrypted_password :string(255)
#  email              :string(50)
#  gender             :string(1)
#  created_at         :datetime
#  updated_at         :datetime
#  salt               :string(255)
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  
  attr_accessible :first_name, :last_name, :username, :email, 
    :gender, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :first_name,  :presence => true,
                          :length => { :maximum => 25 }
  validates :last_name,   :presence => true,
                          :length => { :maximum => 25 }
  validates :username,    :presence => true,
                          :length => { :maximum => 25 },
                          :uniqueness => { :case_sensitive => false }
  validates :email,       :presence => true,
                          :length => { :maximum => 50 },
                          :format => { :with => email_regex }
  validates :gender,      :presence => true,
                          :inclusion => { :in => ['M', 'F'] }
  validates :password,    :presence => true,
                          :confirmation => true,
                          :length => { :within => 6..40 }
                          
  before_save :encrypt_password

  def has_password?(password)
    if salt.blank?
      correct = (encrypted_password == md5_hash(password))
      upgrade_password(password) if correct
      correct
    else
      encrypted_password == encrypt(password)
    end
  end
  
  def self.authenticate(username, submittedPassword)
    user = find_by_username(username)
    return nil if user.nil?
    return user if user.has_password?(submittedPassword)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def display_name
    "#{first_name} #{last_name}"
  end
  
private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def upgrade_password(newPassword)
    if salt.blank?
      self.password = newPassword
      self.password_confirmation = newPassword
      self.salt = make_salt
      self.encrypted_password = encrypt(newPassword)
      save(:validate => false)
    end
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
  def md5_hash(string)
    Digest::MD5.hexdigest(string)
  end
    
end
