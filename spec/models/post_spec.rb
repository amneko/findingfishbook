require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = create(:user)
      fish = create(:fish)
      aquarium = create(:aquarium)
      post = build(:post, user: user, fish: fish, aquarium: aquarium)
      expect(post).to be_valid
    end

    it 'is not valid without a post_image' do
      post = build(:post, fish_id: nil)
      expect(post).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:fish) }
    it { should belong_to(:aquarium) }
  end

  describe 'database' do
    it 'can save to database' do
      expect { create(:post) }.to change(Post, :count).by(1)
    end
  end
end
