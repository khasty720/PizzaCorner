class AddFkStates < ActiveRecord::Migration
  def change
    add_foreign_key :users, :states
  end
end
