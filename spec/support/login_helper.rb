def api_sign_in(account_holder)
  request.headers.merge!("Authorization" => authenticate_with_token(account_holder.token))
end

def authenticate_with_token(token)
  ActionController::HttpAuthentication::Token.encode_credentials(token)
end
