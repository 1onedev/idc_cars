class AddCarToMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :car, index: true, foreign_key: { on_delete: :cascade }
  end
end
