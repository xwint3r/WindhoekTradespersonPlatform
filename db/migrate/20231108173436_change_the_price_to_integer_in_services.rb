class ChangeThePriceToIntegerInServices < ActiveRecord::Migration[7.0]
  def change
    change_column :services, :price, :integer, default: 0
  end
end
