class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: {admin: 0, customer:1}
  has_many :authentication_tokens
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_accessor :name

  def set_default_role
    self.role ||= :customer
  end
end
