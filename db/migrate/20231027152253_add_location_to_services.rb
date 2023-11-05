class AddLocationToServices < ActiveRecord::Migration[7.0]
  def change
    add_reference :services, :location, null: false, foreign_key: true
  end
end
