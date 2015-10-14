class Answer < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :ball

  validates :body, presence: true
end
