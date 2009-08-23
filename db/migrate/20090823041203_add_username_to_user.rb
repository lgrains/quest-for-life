class AddUsernameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    execute "update users set username = login"
    remove_column :users, :login
    add_index :users, :username
  end

  def self.down
    add_column :users, :login, :string
    execute "update users set login = username"
    remove_column :users, :username
    add_index :users, :login
  end
end
