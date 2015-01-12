class Group < ActiveRecord::Base
  validates :name,  :presence => true
  validates :description, :presence => true

  belongs_to :category
  has_many :products, :dependent => :delete_all

end
