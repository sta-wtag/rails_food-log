class Api < Grape::API
    prefix 'api'
    mount Login
    mount PairProgrammingSessions
    mount Items
    add_swagger_documentation
    rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response({
          status: e.status,
          error_msg: e.message,
        }.to_json, 400)
    end
end