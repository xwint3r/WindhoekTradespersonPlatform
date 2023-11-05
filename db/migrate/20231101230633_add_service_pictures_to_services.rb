class AddServicePicturesToServices < ActiveRecord::Migration[7.0]
  def change
    add_column :services, :service_pictures, :json # Use :string if storing as a single string, or use :text for longer JSON content
  end
end
