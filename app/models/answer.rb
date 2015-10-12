class Answer < ActiveRecord::Base
  # What about changing :user to :author and referring to a class_name/foreign_key instead? From the POV of an Answer, :author makes more sense. (This is true in Ball as well!)
  belongs_to :user
  belongs_to :ball

  validates :body, presence: true
end
