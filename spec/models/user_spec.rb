require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = build(:user, password: 'pw')
      expect(user).not_to be_valid
    end
  end

  describe 'database' do
    it 'can save to database' do
      expect { create(:user) }.to change(User, :count).by(1)
    end
  end
end
