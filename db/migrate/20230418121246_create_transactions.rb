class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.string :status
      t.string :stripe_payment_id
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
