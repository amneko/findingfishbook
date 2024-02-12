require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザー登録' do
    it '成功すること' do
      visit root_path
      click_on 'ユーザー登録'
      find('.input', match: :first).set('test')
      find_all('.input')[1].set('test1@example.com')
      find_all('.input')[2].set('password')
      find_all('.input')[3].set('password')
      click_on '登録'
      expect(page).to have_content 'ユーザー登録が完了しました'
      expect(current_path).to eq root_path
    end

    it '失敗すること(項目不足)' do
      visit root_path
      click_on 'ユーザー登録'
      find('.input', match: :first).set('')
      find_all('.input')[1].set('test1@example.com')
      find_all('.input')[2].set('password')
      find_all('.input')[3].set('password')
      click_on '登録'
      expect(page).to have_content 'ユーザー登録に失敗しました'
      expect(current_path).to eq new_user_path
    end
  end

  describe 'ログイン' do
    let!(:user) { FactoryBot.create(:user) }

    it '成功すること' do
      visit root_path
      click_on 'ログイン'
      find('.input', match: :first).set(user.email)
      find_all('.input')[1].set('password')
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'
      expect(current_path).to eq root_path
    end

    it '失敗すること(項目不足)' do
      visit root_path
      click_on 'ログイン'
      find('.input', match: :first).set('')
      find_all('.input')[1].set('password')
      click_button 'ログイン'
      expect(page).to have_content 'ログインに失敗しました'
      expect(current_path).to eq login_path
    end
  end
end
