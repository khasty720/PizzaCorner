class UpdateUsers < ActiveRecord::Migration
  def change
    remove_column :users, :states_id
  end
end
