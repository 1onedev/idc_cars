class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :position, null: false, default: 0

      t.text :question
      t.text :text

      t.timestamps null: false
    end
  end
end
