class ChangePriceFormatInServices < ActiveRecord::Migration[7.0]
  def change
    change_column :services, :price, :string, default: "N$0.00"
  end
end
