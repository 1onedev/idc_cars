class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :name

      t.attachment :cover

      t.text :description
      t.text :text

      t.string :slug
      t.string :seo_title
      t.text :seo_description

      t.timestamps null: false
    end

    add_index :albums, :slug
    add_index :albums, :name
  end
end
