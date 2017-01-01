class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :target_id
      t.string :target_type
      t.integer :source_id
      t.string :source_type
      t.integer :initiator_id
      t.integer :action
      t.text :data

      t.timestamps
    end
    add_index :events, [:target_id, :target_type]
    add_index :events, [:source_id, :source_type]
  end
end
