module Entities
    class PairProgrammingSessionsEntity < Grape::Entity
      expose :project, using: ProjectEntity
      expose :host_user, using: UserEntity
      expose :visitor_user, using: UserEntity
      expose :reviews, using: ReviewEntity
    end
end