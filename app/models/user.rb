require 'bcrypt'

class User < ActiveRecord::Base
  has_many :answers
  has_many :balls

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :hashed_password, presence: true
  validates :hashed_password, length: { minimum: 6 }
  # These two ^^^ won't ever fail, and it's not validating what you think. As soon as the `password: "password"` param key-value get picked up in your controller, it uses your custom `password=` method to set the hashed password. Even an empty string will return a long hashed string as output. So the `hashed_password` will ALWAYS be present.

  # What can we do instead? Well, in the `password=` method, we could grab the `new_password` string and set it to an instance variable. Then, we could write a *private* method that checks whether the length of that string is `< 6` (or any length), and returns an error if that's the case.

  # Look into Active Record Validation docs, under "custom methods," to see how you can put it all together for a new validation.

   def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  def self.authenticate(user_data)
    user = User.find_by(email: user_data[:email])
    return user if user && user.password == user_data[:password]
    # This seems like it will return line 28 if a user is found but the password is wrong, whatever that return value is. Wouldn't that be a user object if a user was found! Uh oh! Check some return values of this method in the console to see if it will ever return nil for an existing email with an incorrect password. If not, make sure you explicitly handle the nil case.
  end

end
