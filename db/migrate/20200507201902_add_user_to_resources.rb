class AddUserToResources < ActiveRecord::Migration[6.0]
  def change
    add_reference :resources, :user, null: false, foreign_key: true
  end
end
