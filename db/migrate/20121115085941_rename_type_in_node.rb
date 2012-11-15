class RenameTypeInNode < ActiveRecord::Migration
  def up
    rename_column :nodes, :type, :classify
  end

  def down
  end
end
