class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :home_type
      t.string :pet_type
      t.string :pet_size
      t.integer :breeding_years
      t.string :address
      t.string :listing_title
      t.text :listing_content
      t.integer :price_pernight
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
