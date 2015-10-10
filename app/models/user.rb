require 'bcrypt'

class User < ActiveRecord::Base
  has_many :answers
  has_many :balls

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :hashed_password, length: { minimum: 6 }

   def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  def self.authenticate(email, input_password)
    user = User.find_by(email: email)
    if user.password == input_password
      user
    else
      nil
    end
  end
end
