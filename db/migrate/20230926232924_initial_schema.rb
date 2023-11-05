class InitialSchema < ActiveRecord::Migration[7.0]
def change
  create_table :users do |t|
    t.string :username
    t.string :email
    t.string :password_digest
    t.integer :role, default: 0 # Add a role attribute with a default role (e.g., Customer)
    t.string :profession # Add user descriptor (e.g., "Plumber")
    # Add other user attributes here

    t.timestamps
  end

    create_table :services do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.string :location
      t.integer :category_id # Reference to service category
      t.integer :user_id # Reference to the service provider (user)
      # Add other service attributes here
      t.timestamps
    end

    create_table :categories do |t|
      t.string :name # Service category (e.g., "Plumbing")
      # Add other category attributes here
      t.timestamps
    end

    create_table :reviews do |t|
      t.text :content
      t.integer :user_id
      t.integer :service_id
      t.integer :rating, default: 0
      # Add other review attributes here
      t.timestamps
    end

    create_table :favorites do |t|
      t.integer :user_id
      t.integer :service_id
      # Add other favorite attributes here
      t.timestamps
    end

    create_table :images do |t|
      t.string :url
      t.integer :service_id
      # Add other image attributes here
      t.timestamps
    end
  end
end
