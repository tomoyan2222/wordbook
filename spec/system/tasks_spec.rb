require 'rails_helper'

describe 'wordbook管理機能', type: :system do
  describe '一覧表示機能'
    before do
      #create user-A
      user_a = FactoryBot.create(:user, name: 'userA', original_name: 'userA1234')
      #create category
      category = FactoryBot.create(:category)
      #create wordbook by user-A
      @title = FactoryBot.create(:title, category_id: category.id, user_id: user_a.id)
    end

    context 'ユーザーAがTitle作成時' do
      before do
        visit sign_in_path
        fill_in 'original_name', with: 'userA1234'
        fill_in 'password', with: 'password'
        click_on 'commit'
      end

      it 'ユーザーAのワードブックが表示される' do
        visit user_word_path(User.find_by(name: 'userA').id)
        expect(page).to have_content 'testbook'
      end
    end

    context 'ユーザーAが単語追加時' do
      before do
        FactoryBot.create(:vocabulary, word: 'testword', meaning: 'テスト', title_id: @title.id)
      end

      it 'ユーザーAのワードブックが表示される' do
        visit list_path(@title.id)
        expect(page).to have_content 'testword'
      end
    end
end