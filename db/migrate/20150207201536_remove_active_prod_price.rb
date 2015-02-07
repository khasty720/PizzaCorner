class RemoveActiveProdPrice < ActiveRecord::Migration
  def change
    remove_column :product_prices, :active
  end
end
