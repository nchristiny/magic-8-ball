class Ball < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :answers
  has_many :answerers, through: :answers


  validates :name, presence: true, uniqueness: true
end
