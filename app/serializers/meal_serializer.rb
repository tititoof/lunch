# frozen_string_literal: true

# == Schema Information
#
# Table name: meals
#
#  id         :bigint           not null, primary key
#  day_at     :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_meals_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class MealSerializer
  include JSONAPI::Serializer
  attributes :name, :day_at, :user_id, :polls, :participates
end
