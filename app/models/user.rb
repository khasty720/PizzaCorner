class User < ActiveRecord::Base
  validates :first_name, :last_name, :street, :city, :zip, :phone, :presence => true

  has_many :orders
  belongs_to :state

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
end
