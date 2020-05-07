class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.integer :hours
      t.string :link
      t.string :title
      t.boolean :completed, default: false
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
