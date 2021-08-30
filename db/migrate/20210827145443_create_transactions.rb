class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :payer, null: false, foreign_key: true
      t.integer :points

      t.timestamps
    end
  end
end
