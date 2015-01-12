class Product < ActiveRecord::Base

  has_many :product_groups, :dependent => :destroy
  has_many :groups, :through => :product_groups
  accepts_nested_attributes_for :product_groups
end
