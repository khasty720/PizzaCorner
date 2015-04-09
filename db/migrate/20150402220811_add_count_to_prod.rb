class AddCountToProd < ActiveRecord::Migration
  def change
    add_column :products, :count, :integer, :default => 0
  end
end
