class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name, :limit => 25
      t.string :last_name, :limit => 25
      t.string :username, :limit => 25
      t.string :encrypted_password
      t.string :email, :limit => 50
      t.string :gender, :limit => 1

      t.timestamps
    end
      
    add_index :users, :username, :unique => true
  end

  def self.down
    remove_index :users, :username
    drop_table :users
  end
end
