class RenameTypeMessages < ActiveRecord::Migration
  def up
    rename_column :messages, :type, :msg_type
  end

  def down
    rename_column :messages, :msg_type, :type
  end
end
