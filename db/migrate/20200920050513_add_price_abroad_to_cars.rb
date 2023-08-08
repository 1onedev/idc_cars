class AddPriceAbroadToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :price_abroad, :integer
  end
end
