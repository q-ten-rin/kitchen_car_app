require "rails_helper"

RSpec.describe 'Posts', type: :system do
  include LoginMacros
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let!(:category) { create(:category, name: "クレープ") }

  describe "ログイン前" do
    context "新規投稿ページにアクセス" do
      it "新規登録ページへのアクセスが失敗する" do
        visit new_post_path
        expect(page).to have_content("ログインもしくはアカウント登録してください。")
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "ログイン後" do
    before { login(user) }

    describe "新規投稿作成" do
      context "フォームの入力値が正常" do
        it "新規投稿が成功する" do
          visit new_post_path
          fill_in "タイトル", with: "test_title"
          expect(page).to have_select("post_category_id")
          select "クレープ", from: "post_category_id"
          fill_in "キッチンカーの名前", with: "test_car"
          click_on "登録する"
          expect(page).to have_content ("test_title")
          expect(page).to have_content ("test_car")
          expect(current_path).to eq posts_path
        end
      end

      context "タイトルが未入力" do
        it "新規投稿が失敗する" do
          visit new_post_path
          fill_in "タイトル", with: ""
          expect(page).to have_select("post_category_id")
          select "クレープ", from: "post_category_id"
          fill_in "キッチンカーの名前", with: "test_car"
          click_on "登録する"
          expect(page).to have_content ("タイトルを入力してください")
          expect(current_path).to eq posts_path
        end
      end

      context "カテゴリーが未選択" do
        it "新規投稿が失敗する" do
          visit new_post_path
          fill_in "タイトル", with: "test_title"
          fill_in "キッチンカーの名前", with: "test_car"
          click_on "登録する"
          expect(page).to have_content ("カテゴリーを入力してください")
          expect(current_path).to eq posts_path
        end
      end

      context "キッチンカー名が未入力" do
        it "新規投稿が失敗する" do
          visit new_post_path
          fill_in "タイトル", with: "test_title"
          expect(page).to have_select("post_category_id")
          select "クレープ", from: "post_category_id"
          fill_in "キッチンカーの名前", with: ""
          click_on "登録する"
          expect(page).to have_content ("キッチンカー名を入力してください")
          expect(current_path).to eq posts_path
        end
      end
    end
  end
end
