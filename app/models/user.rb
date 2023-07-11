class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: {admin: 0, customer:1}
  has_many :authentication_tokens
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  after_initialize :set_default_role, if: :new_record?
  def self.authenticate(email,password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end 
  private

  def set_default_role
    self.role ||= :customer
  end

   
end
