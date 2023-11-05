class ChangeServicePicturesTypeToString < ActiveRecord::Migration[7.0]
  def up
    change_column :services, :service_pictures, :string
  end

  def down
    change_column :services, :service_pictures, :json
  end
end
