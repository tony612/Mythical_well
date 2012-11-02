class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :user_id
      t.boolean :is_read, :default => false

      t.timestamps
    end

    add_index :messages, :user_id
  end
end
