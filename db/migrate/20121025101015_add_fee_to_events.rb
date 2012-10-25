class AddFeeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fee, :string
    add_column :events, :category, :string
  end
end
