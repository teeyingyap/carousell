class AddHasEditedToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :has_edited, :boolean, default: true
  end
end
