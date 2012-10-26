class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :website, :string
    add_column :users, :tagline, :string
  end
end
