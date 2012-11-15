class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :short_name
      t.string :type

      t.timestamps
    end
  end
end
