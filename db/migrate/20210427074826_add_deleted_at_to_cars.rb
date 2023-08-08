class AddDeletedAtToCars < ActiveRecord::Migration[5.2]
  def change
  	add_column :cars, :deleted_at, :datetime
  end
end
