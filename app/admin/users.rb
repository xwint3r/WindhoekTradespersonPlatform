ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :username, :email, :password_digest, :profession, :role, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :firstname, :lastname, :phone_number
  #
  # or
  #
  # permit_params do
  #   permitted = [:username, :email, :password_digest, :profession, :role, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :firstname, :lastname, :phone_number]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :username, :email, :password, :password_confirmation, :role

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :role
    actions
  end

  filter :username
  filter :email

  form do |f|
    f.inputs 'User Details' do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
    end
    f.actions
  end
  
end
