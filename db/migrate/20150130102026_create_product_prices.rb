class CreateProductPrices < ActiveRecord::Migration
  def change
    create_table :product_prices do |t|
      t.decimal :price
      t.boolean :active
      t.references :user, index: true
      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_prices, :users
    add_foreign_key :product_prices, :products
  end
end
