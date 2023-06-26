class AuthenticationToken < ApplicationRecord
  belongs_to :user
  validates :token, presence: true
  scope :valid,  -> { where{ (expires_at == nil) | (expires_at > Time.zone.now) } }
  def self.generate(user)
    payload = { user_id: user.id }
    token = JWT.encode(payload, '12345654321', 'HS256')
    create(token: token, user: user)
  end
end
