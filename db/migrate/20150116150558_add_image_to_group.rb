class AddImageToGroup < ActiveRecord::Migration
  def change
    add_attachment :groups, :image
  end
end
