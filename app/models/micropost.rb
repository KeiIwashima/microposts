class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :iine_relationships, class_name: "Micropostrelationship",
                                foreign_key:  "micropost_id",
                                dependent:  :destroy
  has_many :iinesita_users, through: :iine_relationships, source: :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
