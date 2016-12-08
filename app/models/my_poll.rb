class MyPoll < ApplicationRecord
  validates :title , presence: true , uniqueness:true , length: { maximum: 140 }
  validates :description , presence:true , length:{ maximum: 350 }
  validates :expires_at , presence:true
  validates :user , presence:true
  belongs_to :user

  def is_valid?
    DateTime.now < self.expires_at
  end

end
