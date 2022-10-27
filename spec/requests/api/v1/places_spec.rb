require 'rails_helper'

RSpec.describe 'Api::V1::Place', type: :request do
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

    post api_v1_places_create_path, params: { places: {
      name: Faker::Internet.unique.username(specifier: 6..30),
      address: Faker::Internet.unique.username(specifier: 6..30),
      meal_id: meal.id
    } }, headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('place')
  end

  it '>> show' do
    place = FactoryBot.create(:place)

    get "/api/v1/places/#{place.id}", headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('place')
  end

  it '>> destroy' do
    place = FactoryBot.create(:place, user: @current_user)

    expect do
      delete "/api/v1/places/#{place.id}", headers: @auth_tokens
    end.to change(Place, :count).by(-1)

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('place')
  end
end
