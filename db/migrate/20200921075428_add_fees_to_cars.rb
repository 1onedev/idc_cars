class AddFeesToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :state_fees, :jsonb, default: {}
    add_column :cars, :private_fees, :jsonb, default: {}
  end
end
