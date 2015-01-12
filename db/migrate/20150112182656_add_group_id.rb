class AddGroupId < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.belongs_to :group, index: true

    end
  end
end
