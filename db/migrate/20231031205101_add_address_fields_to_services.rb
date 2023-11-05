class AddAddressFieldsToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :country, :string, default: "Namibia"
    add_column :services, :city, :string, default: "Windhoek"
    add_column :services, :street_address, :string
  end
end
