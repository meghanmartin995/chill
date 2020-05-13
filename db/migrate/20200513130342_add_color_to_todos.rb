class AddColorToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :color, :string
  end
end
