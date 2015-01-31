class ProductPrice < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :price, :presence => true
  validates :user, :presence => true
  validates :product, uniqueness: {scope: :user_id,
    message: "Product Price Already Exists"}, :presence => true
end
