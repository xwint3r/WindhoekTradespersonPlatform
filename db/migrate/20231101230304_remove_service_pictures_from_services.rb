class RemoveServicePicturesFromServices < ActiveRecord::Migration[7.0]
  def change
    remove_column :services, :service_pictures
  end
end
