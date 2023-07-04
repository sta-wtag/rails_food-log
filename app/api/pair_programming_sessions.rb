class PairProgrammingSessions < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }
    before { authenticate! }
    format :json
  
    desc 'End-points for the PairProgrammingSessions'
    namespace :pair_programming_sessions do
      desc 'Retrieve the pairprogramming sessions'
      get do
        sessions = PairProgrammingSession.where(host_user: current_user).or(PairProgrammingSession.where(visitor_user: current_user))
        sessions = sessions.includes(:project, :host_user, :visitor_user, reviews: [:code_samples, :user])
        present sessions, with: Entities::PairProgrammingSessionsEntity
      end
    end
end