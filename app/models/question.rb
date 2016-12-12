class Question < ApplicationRecord
  validates :description , presence:true , length:{minimum:10}
  validates :my_poll , presence:true

  belongs_to :my_poll
  has_many :answers
end
