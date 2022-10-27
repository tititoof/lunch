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
class PlaceSerializer
  include JSONAPI::Serializer
  attributes :name, :address, :meal, :user
end
