class Product < ActiveRecord::Base
  validates :name,  :presence => true
  validates :group_id,  :presence => true
  validates :description, :presence => true
  validates :default_price, :presence => true
  validates :count, :presence => true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  belongs_to :group
  has_many :order_items



end
