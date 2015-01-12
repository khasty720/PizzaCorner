class CreateProductGroups < ActiveRecord::Migration
  def change
    create_table :groups_products do |t|
      t.references :product, index: true
      t.references :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :groups_products, :products
    add_foreign_key :groups_products, :groups
  end
end
