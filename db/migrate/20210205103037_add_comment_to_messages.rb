class AddCommentToMessages < ActiveRecord::Migration[5.2]
  def change
  	add_column :messages, :comment, :text
  end
end
