# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  address    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meal_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_places_on_meal_id  (meal_id)
#  index_places_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (meal_id => meals.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :place do
    name { Faker::Internet.unique.username(specifier: 6..30) }
    address { Faker::Internet.unique.username(specifier: 6..30) }
    user { FactoryBot.create(:user) }
    meal { FactoryBot.create(:meal) }
  end
end
