class AddAddrToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :street, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip, :string
    add_column :orders, :country, :string
  end
end
