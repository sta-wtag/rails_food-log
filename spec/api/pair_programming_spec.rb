require 'rails_helper'

describe '/api' do
  let(:api_key) { create :api_key }
  let(:developer_header) { {'Authorization' => api_key.token} }
  describe '/pair_programming_session' do
    def api_call *params
      get '/api/pair_programming_sessions', *params
    end
    let(:token) { create :authentication_token }
    let(:original_params) { { token: token.token} }
    let(:params) { original_params }

    it_behaves_like 'restricted for developers'
    it_behaves_like 'unauthenticated'
    context 'invalid params' do
      context 'incorrect token' do
        let(:params) { original_params.merge(token: 'invalid') }
    
        it_behaves_like '401'
        it_behaves_like 'json result'
        it_behaves_like 'auditable created'
    
        it_behaves_like 'contains error msg', 'authentication_error'
        it_behaves_like 'contains error code', ErrorCodes::BAD_AUTHENTICATION_PARAMS
      end
    end

    context 'valid params' do
      it_behaves_like '200'
      it_behaves_like 'json result'
    end
  end 
end