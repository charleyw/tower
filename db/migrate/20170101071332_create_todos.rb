class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.integer :author_id, index: true
      t.integer :assignee_id, index: true
      t.timestamp :finished_at
      t.integer :rank, default: 0

      t.timestamps
    end
  end
end
