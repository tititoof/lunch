# frozen_string_literal: true

# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meal_id    :bigint           not null
#  place_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_polls_on_meal_id   (meal_id)
#  index_polls_on_place_id  (place_id)
#  index_polls_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (meal_id => meals.id)
#  fk_rails_...  (place_id => places.id)
#  fk_rails_...  (user_id => users.id)
#
class Poll < ApplicationRecord
  # --- Relationships ---
  belongs_to :user
  belongs_to :meal
  belongs_to :place

  # --- Validations ---
  # User
  validates_presence_of :user, message: 'user_required'
  validates :user, uniqueness: { scope: :meal, message: 'user_meal_not_uniq' }

  # Place
  validates_presence_of :place, message: 'place_required'

  # Meal
  validates_presence_of :meal, message: 'meal_required'
end
