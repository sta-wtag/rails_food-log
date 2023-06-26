module ApiHelpers
    module AuthenticationHelper
        TOKEN_PARAM_NAME = :token   
        def token_value_from_request(token_param = TOKEN_PARAM_NAME)
          params[token_param]
        end

        def current_user
          token = AuthenticationToken.find_by_token(token_value_from_request)
          return nil unless token.present?
          @current_user ||= token.user
        end

        def signed_in?
          !!current_user
        end

        def authenticate!
          unless signed_in?
            AuditLog.create data: 'unauthenticated user access'
            error!({ :error_msg => "authentication_error", :error_code => ErrorCodes::BAD_AUTHENTICATION_PARAMS }, 401)
          end
        end
        def restrict_access_to_developers
          header_token = headers['Authorization']
          key = ApiKey.where{ token == my{ header_token } }
          Rails.logger.info "API call: #{headers}\tWith params: #{params.inspect}" if ENV['DEBUG']
          if key.blank?
            error_code = ErrorCodes::DEVELOPER_KEY_MISSING
            error_msg = 'please aquire a developer key'
            error!({ :error_msg => error_msg, :error_code => error_code }, 401)
            # LogAudit.new({env:env}).execute
          end
        end
    end
end