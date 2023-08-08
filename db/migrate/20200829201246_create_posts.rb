class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name

      t.attachment :cover
      t.boolean :published, null: false, default: false
      t.text :description
      t.text :text

      t.string :slug
      t.string :seo_title
      t.text :seo_description

      t.timestamps null: false
    end

    add_index :posts, :slug
    add_index :posts, :name
  end
end
