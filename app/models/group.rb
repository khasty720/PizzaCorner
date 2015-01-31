class Group < ActiveRecord::Base
  validates :name,  :presence => true
  validates :description, :presence => true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates :image, :attachment_presence => true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  belongs_to :category
  has_many :products, :dependent => :delete_all
  
end
