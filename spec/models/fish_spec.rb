require 'rails_helper'

RSpec.describe Fish, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      location = create(:location)
      fish = build(:fish, location: location)
      expect(fish).to be_valid
    end

    it 'is not valid without a name' do
      fish = build(:fish, name: nil)
      expect(fish).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:location) }
  end

  describe 'database' do
    it 'can save to database' do
      expect { create(:fish) }.to change(Fish, :count).by(1)
    end
  end
end
