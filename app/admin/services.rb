ActiveAdmin.register Service do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :price, :location, :category_id, :user_id, :location_id, :country, :city, :street_address, :region, :latitude, :longitude, :service_pictures
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :location, :category_id, :user_id, :location_id, :country, :city, :street_address, :region, :latitude, :longitude, :service_pictures]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :description, :price, :location, :category_id, :user_id, :location_id, :country, :city, :street_address, :region, :latitude, :longitude, :service_pictures

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :location
    column :category
    column :user
    actions
  end

  filter :name
  filter :description
  filter :price
  filter :location
  filter :category
  filter :user

  form do |f|
    f.inputs 'Service Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :location
      f.input :category
      f.input :user
      f.input :location_id, as: :select, collection: Location.all
      f.input :country, input_html: { value: 'Namibia' }, as: :hidden
      f.input :city, input_html: { value: 'Windhoek' }, as: :hidden
      f.input :street_address
      f.input :region, input_html: { value: 'Khomas Region' }, as: :hidden
      f.input :latitude
      f.input :longitude
      f.input :service_pictures, as: :file, input_html: { multiple: true }
    end
    f.actions
  end
  
end
