require 'rails_helper'

RSpec.describe 'Api::V1::Participate', type: :request do
  include ActionController::RespondWith

  before do
    @current_user = User.new(name: 'Test user name', email: 'toto@toto.fr', password: 'password',
                             nickname: 'my_nickname', confirmed_at: DateTime.now)
    @current_user.save
    login

    @auth_tokens = get_auth_params_from_login_response_headers(response)
  end

  it '>> create' do
    meal = FactoryBot.create(:meal)

    post api_v1_participates_create_path, params: { participates: {
      meal_id: meal.id
    } }, headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('participate')
  end

  it '>> destroy' do
    participate = FactoryBot.create(:participate, user: @current_user)

    expect do
      delete "/api/v1/participates/#{participate.id}", headers: @auth_tokens
    end.to change(Participate, :count).by(-1)

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('participate')
  end

  it '>> cannot destroy' do
    participate = FactoryBot.create(:participate)

    delete "/api/v1/participates/#{participate.id}", headers: @auth_tokens

    expect(response.status).to eq(422)
  end
end
