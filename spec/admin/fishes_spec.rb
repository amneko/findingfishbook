require 'rails_helper'

RSpec.describe "Fishes", type: :system do
  describe '管理者の操作確認' do
    let(:admin_user) { create(:user, :admin) }

    it '管理者は管理画面にログインできること' do
      visit admin_login_path
      find('.input', match: :first).set(admin_user.email)
      find_all('.input')[1].set('password')
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'
    end

    let!(:fish) { FactoryBot.create(:fish, name: "タナゴ") }

    it '管理画面で魚の情報を編集できること' do
      visit admin_login_path
      find('.input', match: :first).set(admin_user.email)
      find_all('.input')[1].set('password')
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'

      visit admin_root_path
      click_on '魚'
      click_on 'タナゴ'
      click_on '編集'
      find('#fish_name').set('タナゴ_after')
      click_on '更新する'
      expect(page).to have_content '情報を更新しました'
      expect(page).to have_content 'タナゴ_after'
      expect(current_path).to eq admin_fishes_path
    end
  end

  describe '非管理者の操作確認' do
    let(:general_user) { create(:user, :general) }

    it '一般ユーザは管理画面にログインできないこと' do
      visit admin_login_path
      find('.input', match: :first).set(general_user.email)
      find_all('.input')[1].set('password')
      click_button 'ログイン'
      expect(page).to have_content '権限がありません'
    end
  end
end
