class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  before_validation :downcase_name
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  private

  def downcase_name
    self.name = name.downcase if name.present?
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "name", "updated_at" ]
  end
end
