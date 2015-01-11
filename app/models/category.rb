class Category < ActiveRecord::Base
  validates :name,  :presence => true

  has_many :groups, :dependent => :delete_all
end
