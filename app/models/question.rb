class Question < ApplicationRecord
  belongs_to :my_poll
  validates :description , presence:true , length:{minimum:10}
  validates :my_poll , presence:true
end
