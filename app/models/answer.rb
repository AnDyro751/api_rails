class Answer < ApplicationRecord
  validates :description , presence:true
  validates :question , presence:true
  belongs_to :question
end
