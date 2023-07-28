module OauthHelper
  def authenticate_request
    application = Doorkeeper::Application.create!(name: "MyApp", redirect_uri: "http://localhost")
    token = Doorkeeper::AccessToken.create!(application_id: application.id, resource_owner_id: nil, scopes: "")

    request.headers['Authorization'] = "Bearer #{token.token}"
  end
end
