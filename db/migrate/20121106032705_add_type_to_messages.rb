class AddTypeToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :type, :integer
  end
end
