class AddDescriptionToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :description, :string
  end
end
