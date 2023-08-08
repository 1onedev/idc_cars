class CreateSlides < ActiveRecord::Migration[5.2]
  def change
    create_table :slides do |t|
      t.integer :position
      t.attachment :image

      t.string :first_title
      t.string :second_title
      t.string :button_title
      t.string :button_url

      t.timestamps null: false
    end
  end
end
