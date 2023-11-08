class ChangePriceFormatInServices < ActiveRecord::Migration[7.0]
  def change
    change_column_default :services, :price, from: "N$0.00", to: nil
  end
end
