class AddNodeIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :node_id, :integer
    add_index :events, :node_id
  end
end
