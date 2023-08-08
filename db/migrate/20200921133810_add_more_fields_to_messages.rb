class AddMoreFieldsToMessages < ActiveRecord::Migration[5.2]
  def change
    change_table :messages, bulk: true do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :subject
    end
  end
end
