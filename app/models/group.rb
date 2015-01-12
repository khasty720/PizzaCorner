class Group < ActiveRecord::Base
  validates :name,  :presence => true
  validates :description, :presence => true

  belongs_to :category
  has_many :product_groups, :dependent => :destroy
  has_many :products, :through => :product_groups
end
