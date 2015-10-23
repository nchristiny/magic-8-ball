require 'bcrypt'

class User < ActiveRecord::Base
  has_many :answers, foreign_key: "answerer_id"
  has_many :balls, foreign_key: "author_id"

  validates :username, :email, { presence: true, uniqueness: true }
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validate  :password_required

   def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @raw_password = new_password
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  def self.authenticate(user_data)
    @user = User.find_by(email: user_data[:email])
    @user && @user.password == user_data[:password]
  end

  private

  def password_required
    if @raw_password && @raw_password.length < 6
      errors.add(:password, "is too short")
    end
    if new_record? && !@raw_password
      errors.add(:password, "is required!")
    end
  end

end
