module LoginMacros
  def login(user)
    visit root_path
    find("#login-button").click
    fill_in "名前", with: user.name
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    find("#login-button").click
  end
end
