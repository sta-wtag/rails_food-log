class PairProgrammingSession < ApplicationRecord
  belongs_to :project
  belongs_to :host_user, class_name: 'User', foreign_key: 'host_user_id'
  belongs_to :visitor_user, class_name: 'User', foreign_key: 'visitor_user_id'

  has_many :reviews
end
