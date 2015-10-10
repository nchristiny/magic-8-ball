class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :ball

  validates :body, presence: true
end
