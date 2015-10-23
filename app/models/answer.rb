class Answer < ActiveRecord::Base
  belongs_to :answerer, class_name: "User", foreign_key: "answerer_id"
  belongs_to :ball

  validates :body, presence: true
end
