class AddDeliveryFlagOrder < ActiveRecord::Migration
  def change
    add_column :orders, :delivery, :boolean, :default => false
  end
end
