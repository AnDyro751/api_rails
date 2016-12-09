class User < ApplicationRecord
  validates :name, presence:true,length:{in:4..20}
  validates :email , presence:true , email:true , uniqueness:true
  validates :provider , presence:true
  validates :uid , presence:true

  has_many :tokens
  has_many :my_polls
  def self.from_omniauth(auth)
    where(uid: auth[:uid] , provider: auth[:provider]).first_or_create do |user|
      if auth[:info]
        user.email = auth[:info][:email]
        user.name = auth[:info][:name]
      end
    end
  end

end
