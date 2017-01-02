class AddStateToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :state, :string, default: 'pending'
  end
end
