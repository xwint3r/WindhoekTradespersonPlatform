class UpdateAssociationsAgain < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :messages, :users
    remove_foreign_key :messages, :rooms
    add_foreign_key :messages, :users, on_delete: :cascade
    add_foreign_key :messages, :rooms, on_delete: :cascade
  end
end
