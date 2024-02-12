require 'rails_helper'

RSpec.describe Aquarium, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      prefecture = create(:prefecture)
      aquarium = build(:aquarium, prefecture: prefecture)
      expect(aquarium).to be_valid
    end

    it 'is not valid without a name' do
      aquarium = build(:aquarium, name: nil)
      expect(aquarium).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:prefecture) }
  end

  describe 'database' do
    it 'can save to database' do
      expect { create(:aquarium) }.to change(Aquarium, :count).by(1)
    end
  end
end
