class AddViewedToFeedbacks < ActiveRecord::Migration[5.2]
  def change
  	add_column :subscribers, :viewed, :boolean, null: false, default: false
  	add_column :messages, :viewed, :boolean, null: false, default: false
  end
end
