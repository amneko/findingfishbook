require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:user) { create(:user) }
  let!(:fish) { create(:fish) }
  let!(:aquarium) { create(:aquarium) }
  let!(:post) { create(:post, user: user, fish: fish, aquarium: aquarium) }

  def login_user
    visit login_path
    find('.input', match: :first).set(user.email)
    find_all('.input')[1].set('password')
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  describe '一覧' do
    it 'ヘッダーの「投稿一覧」をクリックすると「投稿一覧」という文字が存在すること' do
      visit root_path
      click_on '投稿一覧'
      expect(page).to have_content '投稿一覧'
    end

    it '投稿が表示されること' do
      login_user
      visit posts_path
      expect(page).to have_content '撮影日'
      expect(page).to have_content '投稿詳細を見る'
    end
  end

  describe '詳細' do
    it '「投稿詳細を見る」ボタンをクリックすると投稿の詳細が表示されること' do
      login_user
      visit posts_path
      click_on '投稿詳細を見る'
      expect(page).to have_content '撮影日'
      expect(page).to have_content '魚の名前'
      expect(page).to have_content '出会った水族館'
    end
  end

  describe '投稿' do
    it '投稿が成功すること' do
      login_user
      visit new_post_path
      allow(Vision).to receive(:image_analysis).and_return(true)
      attach_file('post[post_image]', '/Users/aina/Downloads/fish_52.JPG', make_visible: true)
      find("#post_fish_id").find("option[value='1']").select_option
      find("#post_aquarium_id").find("option[value='1']").select_option
      fill_in 'post[shooting_date]', with: Date.new(2024, 02, 11)
      fill_in 'post[body]', with: 'This is a test post.'
      click_on '投稿する'
      expect(page).to have_content '投稿しました'
      expect(current_path).to eq posts_path
    end

    it '投稿が失敗すること(魚と水族館未選択)' do
      login_user
      visit new_post_path
      allow(Vision).to receive(:image_analysis).and_return(true)
      attach_file('post[post_image]', '/Users/aina/Downloads/fish_52.JPG', make_visible: true)
      find("#post_fish_id").find("option[value='']").select_option
      find("#post_aquarium_id").find("option[value='']").select_option
      fill_in 'post[shooting_date]', with: Date.new(2024, 02, 11)
      fill_in 'post[body]', with: 'This is a test post.'
      click_on '投稿する'
      expect(page).to have_content '投稿できませんでした'
      expect(current_path).to eq new_post_path
    end

    it '投稿が失敗すること(魚以外の画像を選択)' do
      login_user
      visit new_post_path
      attach_file('post[post_image]', '/Users/aina/Downloads/sample_icon.png', make_visible: true)
      find("#post_fish_id").find("option[value='1']").select_option
      find("#post_aquarium_id").find("option[value='1']").select_option
      fill_in 'post[shooting_date]', with: Date.new(2024, 02, 11)
      fill_in 'post[body]', with: 'This is a test post.'
      click_on '投稿する'
      expect(page).to have_content '魚の画像の投稿をお願いします'
      expect(current_path).to eq new_post_path
    end
  end
end
