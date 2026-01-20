require "rails_helper"

RSpec.describe Post, type: :model do
  describe "バリデーションチェック" do
    it "title が空だと無効" do
      post = build(:post, title: "")
      expect(post).to be_invalid
    end

    it "kitchen_car_name が空だと無効" do
      post = build(:post, kitchen_car_name: "")
      expect(post).to be_invalid
    end
  end
end
