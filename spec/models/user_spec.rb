require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "name が空だと無効" do
      user = build(:user, name: nil)
      expect(user).to be_invalid
    end

    it "email が空だと無効" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end

    it "email が重複すると無効" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).to be_invalid
    end
  end
end
