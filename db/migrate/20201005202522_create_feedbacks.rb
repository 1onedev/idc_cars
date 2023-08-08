class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.integer :stars, null: false, default: 1
      t.text :text

      t.timestamps null: false
    end
  end
end
