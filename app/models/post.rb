class Post < ApplicationRecord
  before_validation :set_uuid, on: :create
  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, dependent: :destroy
  belongs_to :category
  validates :title, presence: true
  validates :kitchen_car_name, presence: true
  validates :body, length: { maximum: 500 }
  after_commit :optimize_images, on: :create

  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    column_names
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category", "comments", "favorites", "images_attachments", "images_blobs", "post_tags", "tags", "user" ]
  end

  def to_param
    uuid
  end

  private

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def optimize_images
    images.each do |image|
      optimized = image.variant(
        resize_to_limit: [ 1200, 1200 ],
        format: :webp
      ).processed

      image.blob.update!(content_type: "image/webp")
    end
  end
end
