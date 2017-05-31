class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :listing, index: true, foreign_key: true
      t.timestamps
    end
  end
end
