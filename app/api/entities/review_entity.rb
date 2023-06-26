module Entities
    class ReviewEntity < Grape::Entity
      expose :user, using: UserEntity
      expose :code_samples, using: CodeSampleEntity
    end
end