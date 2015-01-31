class AddDefaultPriceProduct < ActiveRecord::Migration
  def change
    add_column :products, :default_price, :decimal, :precision => 8, :scale => 2
  end
end
