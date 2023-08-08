class AddRatingsToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :rating_value, :float
    add_column :cars, :review_count, :integer
  end
end
