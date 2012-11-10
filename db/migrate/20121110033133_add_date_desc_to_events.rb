class AddDateDescToEvents < ActiveRecord::Migration
  def change
    add_column :events, :date_desc, :string
  end
end
