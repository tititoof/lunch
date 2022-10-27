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
require 'rails_helper'

RSpec.describe Poll, type: :model do
  subject { FactoryBot.create(:poll) }

  context 'model validation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a meal' do
      subject.meal = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a place' do
      subject.place = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).not_to be_valid
    end
  end

  context 'model relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:meal) }
    it { should belong_to(:place) }
  end
end
