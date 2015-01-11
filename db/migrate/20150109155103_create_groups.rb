class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :groups, :categories
  end
end
