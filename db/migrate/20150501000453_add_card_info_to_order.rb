class AddCardInfoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :card_code, :string
    add_column :orders, :card_month, :string
    add_column :orders, :card_year, :string
  end
end
