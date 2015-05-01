class User < ActiveRecord::Base
  validates :first_name, :last_name, :street, :city, :state, :zip, :country, :phone, :presence => true

  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
