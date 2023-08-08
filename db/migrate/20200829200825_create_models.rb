class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :models do |t|
      t.references :mark, index: true, foreign_key: { on_delete: :cascade }

      t.string :name
      t.text :description
      t.text :text

      t.string :slug
      t.string :seo_title
      t.text :seo_description

      t.integer :cars_count, null: false, default: 0

      t.timestamps null: false
    end

    add_index :models, :slug
    add_index :models, :name
    add_index :models, :cars_count
  end
end
