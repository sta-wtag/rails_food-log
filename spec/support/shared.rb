RSpec.shared_examples 'json result' do
  specify 'returns JSON' do
    api_call params
    expect { JSON.parse(response.body) }.not_to raise_error
  end
end

RSpec.shared_examples '400' do
  specify 'returns 400' do
    api_call params
    expect(response.status).to eq(400)
  end
end

RSpec.shared_examples 'contains error msg' do |msg|
  specify "error msg is #{msg}" do
    api_call params
    json = JSON.parse(response.body)
    expect(json['error_msg']).to eq(msg)
  end
end

RSpec.shared_examples '200' do
    specify 'returns 200' do
      api_call params
      expect(response.status).to eq(200)
    end
end

RSpec.shared_examples 'restricted for developers' do
    context 'without developer key' do
      specify 'should be an unauthorized call' do
        api_call params
        expect(response.status).to eq(401)
      end
      specify 'error code is 1001' do
        api_call params
        json = JSON.parse(response.body)
        expect(json['error_code']).to eq(ErrorCodes::DEVELOPER_KEY_MISSING)
      end
    end
end

RSpec.shared_examples 'unauthenticated' do
    context 'unauthenticated' do
      specify 'returns 401 without token' do
        api_call params.except(:token), developer_header
        expect(response.status).to eq(401)
      end
      specify 'returns JSON' do
        api_call params.except(:token), developer_header
        json = JSON.parse(response.body)
      end
    end
end

RSpec.shared_examples 'contains error code' do |code|
  specify "error code is #{code}" do
    api_call params, developer_header
    json = JSON.parse(response.body)
    expect(json['error_code']).to eq(code)
  end
end

RSpec.shared_examples 'contains error msg' do |msg|
  specify "error msg is #{msg}" do
    api_call params, developer_header
    json = JSON.parse(response.body)
    expect(json['error_msg']).to eq(msg)
  end
end

RSpec.shared_examples 'auditable created' do
  specify 'creates an api call audit' do
    expect do
      api_call params, developer_header
    end.to change{ AuditLog.count }.by(1)
  end
end