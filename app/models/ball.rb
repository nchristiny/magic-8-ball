class Ball < ActiveRecord::Base
  belongs_to :user
  has_many :answers


  validates :name, presence: true, uniqueness: true
end
