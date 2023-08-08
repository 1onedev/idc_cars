class AddStateToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :state, :integer, null: false, default: 0
  end
end
