# == Schema Information
# Schema version: 20110512225310
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
#

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

private
  def encrypt_password
    
  end
    
end
