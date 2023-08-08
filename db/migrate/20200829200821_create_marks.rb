class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.string :name
      t.attachment :cover
      t.text :description
      t.text :text

      t.string :slug
      t.string :seo_title
      t.text :seo_description

      t.integer :cars_count, null: false, default: 0

      t.timestamps null: false
    end

    add_index :marks, :slug
    add_index :marks, :name
    add_index :marks, :cars_count
  end
end
