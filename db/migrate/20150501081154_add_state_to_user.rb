class AddStateToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
    t.references :states, index: true
    end
  #add_foreign_key :users, :states
  end
end
