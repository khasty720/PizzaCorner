class AlterProdPrice < ActiveRecord::Migration
  def change
    change_column :product_prices, :price, :decimal, :precision => 8, :scale => 2
  end
end
