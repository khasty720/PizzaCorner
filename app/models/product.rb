class Product < ActiveRecord::Base
  validates :name,  :presence => true
  validates :description, :presence => true
  validates :default_price, :presence => true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  #validates :image, :attachment_presence => true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  belongs_to :group
  has_many :product_prices
  has_many :users , through: :product_prices


end
