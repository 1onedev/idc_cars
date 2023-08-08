class AddFieldsInUkraineForCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :in_ukraine, :integer, null: false, default: false
  end
end
