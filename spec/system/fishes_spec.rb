require 'rails_helper'

RSpec.describe "Fishes", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:fish) { FactoryBot.create(:fish, name: "タナゴ") }

  def login_user
    visit login_path
    find('.input', match: :first).set(user.email)
    find_all('.input')[1].set('password')
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  it 'ヘッダーの「魚一覧」をクリックし一覧が表示されること' do
    visit root_path
    click_on '魚一覧'
    expect(page).to have_content 'タナゴ'
  end

  it '一覧で魚の名前をクリックし詳細が表示されること' do
    login_user
    visit fishes_path
    click_on 'タナゴ'
    expect(page).to have_content 'あつまれどうぶつの森の情報'
    expect(page).to have_content '出会える水族館'
    expect(page).to have_content 'みんなの投稿'
  end
end
