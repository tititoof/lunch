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
require 'rails_helper'

RSpec.describe Place, type: :model do
  subject { FactoryBot.create(:place) }

  context 'model validation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without an address' do
      subject.address = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a meal' do
      subject.meal = nil
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
  end
end
