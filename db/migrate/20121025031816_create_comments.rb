class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.datetime :time
      t.integer :event_id

      t.timestamps
    end
  end
end
