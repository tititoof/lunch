# == Schema Information
#
# Table name: participates
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meal_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_participates_on_meal_id  (meal_id)
#  index_participates_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (meal_id => meals.id)
#  fk_rails_...  (user_id => users.id)
#
class ParticipateSerializer
  include JSONAPI::Serializer
  attributes :user, :meal
end
