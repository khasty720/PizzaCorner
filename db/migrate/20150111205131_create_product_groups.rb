class CreateProductGroups < ActiveRecord::Migration
  def change
    create_table :product_groups do |t|
      t.references :product, index: true
      t.references :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_groups, :products
    add_foreign_key :product_groups, :groups
  end
end
