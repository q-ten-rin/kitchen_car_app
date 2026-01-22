require "rails_helper"

RSpec.describe "Users", type: :system do
  describe "ログイン前" do
    describe "ユーザー新規登録" do
      context "フォームの入力値が正常" do
        it "ユーザーの新規作成が成功する" do
          visit new_user_registration_path
          fill_in "名前", with: "test_user"
          fill_in "メールアドレス", with: "email@example.com"
          fill_in "user_password", with: "password"
          fill_in "user_password_confirmation", with: "password"
          click_on "新規登録"
          expect(page).to have_content "アカウント登録が完了しました。"
          expect(current_path).to eq posts_path
        end
      end

      context "メールアドレスが未入力" do
        it "ユーザーの新規作成が失敗する" do
          visit new_user_registration_path
          fill_in "名前", with: "test_user"
          fill_in "メールアドレス", with: ""
          fill_in "user_password", with: "password"
          fill_in "user_password_confirmation", with: "password"
          click_on "新規登録"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq user_registration_path
        end
      end

      context "登録済のメールアドレスを使用" do
        it "ユーザーの新規作成が失敗する" do
          existed_user = create(:user)
          visit new_user_registration_path
          fill_in "名前", with: "test_user"
          fill_in "メールアドレス", with: existed_user.email
          fill_in "user_password", with: "password"
          fill_in "user_password_confirmation", with: "password"
          click_on "新規登録"
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(current_path).to eq user_registration_path
        end
      end
    end
  end
end
  