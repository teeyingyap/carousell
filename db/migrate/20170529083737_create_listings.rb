class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.integer :condition
      t.json :photos

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
