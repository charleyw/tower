class AddSoftDeleteToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :soft_deleted, :boolean, default: false
    add_column :todos, :soft_deleted_at, :timestamp
  end
end
