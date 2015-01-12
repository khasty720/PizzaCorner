class ProductGroup < ActiveRecord::Base
  validates :group_id,  :presence => true
  validates :product_id, :presence => true

  belongs_to :product
  belongs_to :group
end
