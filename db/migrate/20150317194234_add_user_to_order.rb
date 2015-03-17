class AddUserToOrder < ActiveRecord::Migration
    def change
      change_table :orders do |t|
        t.references :user, index: true
    end
      add_foreign_key :orders, :users
    end
end
