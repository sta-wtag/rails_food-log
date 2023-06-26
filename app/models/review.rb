class Review < ApplicationRecord
  belongs_to :pair_programming_session
  belongs_to :user

  has_many :code_samples
end
