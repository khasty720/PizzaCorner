class ChangePercisionOrderTotal < ActiveRecord::Migration
  def change
    change_column :orders, :total, :decimal, :precision => 12, :scale => 2
  end
end
