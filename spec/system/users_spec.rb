require 'rails_helper'

describe 'ユーザーテスト', type: :system do
  before do
    user = FactoryBot.create(:user)
  end

  describe '有効なログイン' do
    before do
      visit login_path
      fill_in 'ID', with: 'yanasinn'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
    end

    it 'ログインユーザーのホーム画面でIDが表示される' do
      expect(page).to have_content 'yanasinn'
    end
  end
end
