class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.string :link
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
