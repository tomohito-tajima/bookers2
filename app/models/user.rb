class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #ファロー・フォロワー機能のアソシエーション
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  #ここまで
  #ファロー・フォロワー機能のメソッド
  def follow(user_id)
    unless self.id == user_id.to_i
      self.relationships.create(followed_id: user_id) #self = current_userだけに限定しないため
    end
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  #ここまで


  attachment :profile_image

  validates :name, length: {minimum: 2, maximum: 20 }, uniqueness: true

  validates :introduction, length: {maximum: 50 }
end
