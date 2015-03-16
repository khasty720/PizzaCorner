class User < ActiveRecord::Base
  validates :first_name, :last_name, :street, :city, :state, :zip, :country, :company, :presence => true

  has_many :product_prices
  has_many :products , through: :product_prices

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #----- Mailing List -------
  after_create :sign_up_for_mailing_list

  def sign_up_for_mailing_list
    MailingListSignupJob.perform_later(self)
  end

  def subscribe
    mailchimp = Gibbon::API.new(Rails.application.secrets.mailchimp_api_key)
    result = mailchimp.lists.subscribe({
      :id => Rails.application.secrets.mailchimp_list_id,
      :email => {:email => self.email},
      :merge_vars => {:FNAME => self.first_name, :LNAME => self.last_name },
      :double_optin => false,
      :update_existing => true,
      :send_welcome => true
      })
    Rails.logger.info("Subscribed #{self.email} to MailChimp") if result
  end
  #---------------------------

end
