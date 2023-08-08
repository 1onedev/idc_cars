class AddPositionToImages < ActiveRecord::Migration[5.2]
  def change
  	add_column :images, :position, :integer, null: false, default: 0
  end
end
