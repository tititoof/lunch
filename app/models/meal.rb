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
class Meal < ApplicationRecord
  # --- Relationships ---
  belongs_to :user

  has_many :participates
  has_many :polls

  # --- Validations ---
  # User
  validates_presence_of :user, message: 'user_required'

  # Name
  validates_presence_of :name, message: 'name_required'
  validates_length_of :name, within: 6..30, too_long: 'name_too_long', too_short: 'name_too_short'

  # Day_at
  validates_presence_of :day_at, message: 'day_at_required'
end
