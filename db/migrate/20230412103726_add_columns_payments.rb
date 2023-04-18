class AddColumnsPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :credit_card_number, :string
    add_column :orders, :credit_card_number, :string
    add_column :payments, :credit_card_exp_month, :string
    add_column :orders, :credit_card_exp_month, :string
    add_column :orders, :credit_card_exp_year, :string
    add_column :payments, :credit_card_exp_year, :string
    add_column :payments, :credit_card_cvv, :string
    add_column :orders, :credit_card_cvv, :string
    
  end
end
