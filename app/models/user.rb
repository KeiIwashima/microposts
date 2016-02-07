class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :location, length: { maximum: 10 } 
    validates :about, length: { maximum: 100 }
    has_secure_password
    has_many :microposts
    
    has_many :iine_relationships, class_name: "Micropostrelationship",
                                  foreign_key:  "user_id",
                                  dependent:  :destroy
    has_many :iinesita_microposts, through: :iine_relationships, source: :micropost
    
    has_many :following_relationships, class_name:  "Relationship",
                                       foreign_key: "follower_id",
                                       dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    has_many :follower_relationships,  class_name:  "Relationship",
                                       foreign_key: "followed_id",
                                       dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    #------  ここからlike ------
    has_many :like_relationships,      class_name:  "LikeRelationship",
                                       foreign_key: "like_id",
                                       dependent:   :destroy
    has_many :like_users, through: :like_relationships, source: :liked
    
    #------ ここからliked ------
    has_many :liked_relationships,     class_name:  "LikeRelationship",
                                       foreign_key: "liked_id",
                                       dependent:   :destroy
    has_many :liked_users, through: :liked_relationships, source: :like

    # 他のユーザーをフォローする
    def follow(other_user)
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end

    # フォローしているユーザーをアンフォローする
    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
    end

    # あるユーザーをフォローしているかどうか？
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    #-----------ここからlike
    
    # 他のユーザーをlikeする
    def like(other_user)
        like_relationships.find_or_create_by(liked_id: other_user.id)
    end

    # likeしているユーザーをunlikeする
    def unlike(other_user)
        like_relationship = like_relationships.find_by(liked_id: other_user.id)
        like_relationship.destroy if like_relationship
    end

    # あるユーザーをlikeしているかどうか？
    def like?(other_user)
        like_users.include?(other_user)
    end
    
    #-----------ここからiine
    
    # 他のmicropostをiineする
    def iine(micropost)
        iine_relationships.find_or_create_by(micropost_id: micropost.id)
    end

    # iineしているmicropostをuniineする
    def uniine(micropost)
        iine_relationship = iine_relationships.find_by(micropost_id: micropost.id)
        iine_relationship.destroy if iine_relationship
    end

    # あるmicropostをiineしているかどうか？
    def iine?(micropost)
        iinesita_microposts.include?(micropost)
    end
    
    
    def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
    end
  
end

