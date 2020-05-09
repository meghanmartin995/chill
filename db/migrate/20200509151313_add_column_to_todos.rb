class AddColumnToTodos < ActiveRecord::Migration[6.0]
  def change
    add_reference :todos, :column, null: false, foreign_key: true
  end
end
