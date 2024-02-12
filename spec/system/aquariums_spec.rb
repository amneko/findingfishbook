require 'rails_helper'

RSpec.describe "Aquariums", type: :system do
  let!(:user) { create(:user) }
  let!(:prefecture) { create(:prefecture) }
  let!(:aquarium) { create(:aquarium, prefecture: prefecture) }

  def login_user
    visit login_path
    find('.input', match: :first).set(user.email)
    find_all('.input')[1].set('password')
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  it 'ヘッダーの「水族館一覧」をクリックし水族館MAPが表示されること' do
    login_user
    visit root_path
    click_on '水族館一覧'
    expect(page).to have_content '東京'
  end

  it '各地域の水族館MAPに水族館の名前が表示されること' do
    login_user
    visit map_path
    click_on '東京'
    expect(page).to have_content '東京'
    expect(page).to have_content 'テスト水族館'
  end

  it '水族館一覧に水族館の名前が表示されること' do
    login_user
    visit aquariums_path
    expect(page).to have_content 'No'
    expect(page).to have_content '名前'
    expect(page).to have_content '住所'
    expect(page).to have_content 'Webサイト'
    expect(page).to have_content 'テスト水族館'
  end
end
