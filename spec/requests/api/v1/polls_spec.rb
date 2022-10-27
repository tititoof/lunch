require 'rails_helper'

RSpec.describe 'Api::V1::Poll', type: :request do
  include ActionController::RespondWith

  before do
    @current_user = User.new(name: 'Test user name', email: 'toto@toto.fr', password: 'password',
                             nickname: 'my_nickname', confirmed_at: DateTime.now)
    @current_user.save
    login

    @auth_tokens = get_auth_params_from_login_response_headers(response)
  end

  it '>> create' do
    place = FactoryBot.create(:place)

    post api_v1_polls_create_path, params: { polls: {
      place_id: place.id,
      meal_id: place.meal.id
    } }, headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('poll')
  end

  it '>> cannot create' do
    place = FactoryBot.create(:place)
    FactoryBot.create(:poll, user: @current_user, place:, meal: place.meal)

    post api_v1_polls_create_path, params: { polls: {
      place_id: place.id,
      meal_id: place.meal.id
    } }, headers: @auth_tokens

    expect(response.status).to eq(422)
  end
end
