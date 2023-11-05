class AddServiceImage < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :service_pictures, :string
  end
end
