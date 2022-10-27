require 'rails_helper'

RSpec.describe 'Api::V1::Meal', type: :request do
  include ActionController::RespondWith

  before do
    @current_user = User.new(name: 'Test user name', email: 'toto@toto.fr', password: 'password',
                             nickname: 'my_nickname', confirmed_at: DateTime.now)
    @current_user.save
    login

    @auth_tokens = get_auth_params_from_login_response_headers(response)
  end

  it '>> create' do
    post api_v1_meals_create_path, params: { meals: {
      name: Faker::Internet.unique.username(specifier: 6..30),
      day_at: Time.now
    } }, headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('meal')
  end

  it '>> cannot create' do
    post api_v1_meals_create_path, params: { meals: {
      name: Faker::Internet.unique.username(specifier: 31..35),
      day_at: Time.now
    } }, headers: @auth_tokens

    expect(response.status).to eq(422)
    expect(JSON.parse(response.body, symbolize_names: true))
      .to include({ name: ['name_too_long'] })
  end

  it '>> show' do
    meal = FactoryBot.create(:meal)

    get "/api/v1/meals/#{meal.id}", headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('meal')
  end

  it '>> cannot show' do
    get '/api/v1/meals/150', headers: @auth_tokens

    expect(response.status).to eq(422)
  end

  it '>> update' do
    meal = FactoryBot.create(:meal, user: @current_user)

    post "/api/v1/meals/#{meal.id}/update", params: { meals: {
      name: Faker::Internet.unique.username(specifier: 6..30),
      day_at: meal.day_at
    } }, headers: @auth_tokens

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('meal')
  end

  it '>> cannot update' do
    meal = FactoryBot.create(:meal)

    post "/api/v1/meals/#{meal.id}/update", params: { meals: {
      name: Faker::Internet.unique.username(specifier: 6..30),
      day_at: meal.day_at
    } }, headers: @auth_tokens

    expect(response.status).to eq(422)
  end

  it '>> destroy' do
    meal = FactoryBot.create(:meal, user: @current_user)

    expect do
      delete "/api/v1/meals/#{meal.id}", headers: @auth_tokens
    end.to change(Meal, :count).by(-1)

    expect(response.status).to eq(200)
    expect(response).to match_response_schema('meal')
  end

  it '>> cannot destroy' do
    meal = FactoryBot.create(:meal)

    delete "/api/v1/meals/#{meal.id}", headers: @auth_tokens

    expect(response.status).to eq(422)
  end
end
