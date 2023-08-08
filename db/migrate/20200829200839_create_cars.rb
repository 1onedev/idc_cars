class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.references :mark, index: true, foreign_key: { on_delete: :cascade }
      t.references :model, index: true, foreign_key: { on_delete: :cascade }

      t.string :name
      t.string :vin_code
      t.attachment :cover
      t.boolean :published, null: false, default: false
      t.text :description
      t.text :text
      t.float :price
      t.boolean :promo, null: false, default: false

      # enums
      t.integer :vehicle_type, null: false, default: 0
      t.integer :body_type, null: false, default: 0
      t.integer :gearbox_type, null: false, default: 0
      t.integer :fuel_type, null: false, default: 0
      t.integer :drive_type, null: false, default: 0
      t.integer :color, null: false, default: 0

      # characteristic
      t.integer :year
      t.integer :mileage
      t.float :engine_capacity
      t.integer :doors_number
      t.integer :seats_number
      t.boolean :metallic, null: false, default: true
      t.integer :power

      t.text :video

      t.string :slug
      t.string :seo_title
      t.text :seo_description

      t.timestamps null: false
    end

    add_index :cars, :slug
    add_index :cars, :name
  end
end
