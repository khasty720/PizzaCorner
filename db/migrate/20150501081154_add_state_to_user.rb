class AddStateToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
    t.references :states, index: true, foreign_key: true
    end
  end
end
