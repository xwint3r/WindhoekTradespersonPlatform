class AddForeignKeyConstraintToReviews < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :reviews, :users, column: :user_id, on_delete: :cascade
  end
end
