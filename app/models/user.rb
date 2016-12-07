class User < ApplicationRecord
  validates :name, presence:true,length:{in:4..20}
  validates :email , uniqueness:true , presence:true , email:true
  validates :provider , presence:true
  validates :uid , presence:true

  has_many :tokens
end
