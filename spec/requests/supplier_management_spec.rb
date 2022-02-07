require 'rails_helper'

describe 'supplier Requests', type: :request do
  it 'should refuse supplier creation if unauthenticated' do
    # Arrange

    # Act
    post '/suppliers'

    # Assert
    expect(response.status).to eq 302
    expect(response.redirect_url).to eq new_user_session_url
    expect(response).to redirect_to(new_user_session_url)
  end

  it 'should refuse supplier creation if unauthenticated - 2' do
    # Arrange

    # Act
    post '/suppliers'
    follow_redirect!

    # Assert
    expect(response.body).to include 'Entrar'
  end
end
