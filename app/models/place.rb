# frozen_string_literal: true

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
class Place < ApplicationRecord
  # --- Relationships ---
  belongs_to :user
  belongs_to :meal

  # --- Validations ---
  # User
  validates_presence_of :user, message: 'user_required'

  # Meal
  validates_presence_of :meal, message: 'meal_required'

  # Name
  validates_presence_of :name, message: 'name_required'
  validates_length_of :name, within: 6..30, too_long: 'name_too_long', too_short: 'name_too_short'

  # Address
  validates_presence_of :address, message: 'address_required'
  validates_length_of :address, within: 6..200, too_long: 'address_too_long', too_short: 'address_too_short'
end
