class AddFieldsToPostsAndCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :label_status, :integer, null: false, default: 0
    add_column :posts, :put_to_ticker, :boolean, null: false, default: false
  end
end
