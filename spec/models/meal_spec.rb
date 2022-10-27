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
require 'rails_helper'

RSpec.describe Meal, type: :model do
  subject { FactoryBot.create(:meal) }

  context 'model validation' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a day_at' do
      subject.day_at = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).not_to be_valid
    end

    context 'model relationships' do
      it { should belong_to(:user) }
    end
  end
end
