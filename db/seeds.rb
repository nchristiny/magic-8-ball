require 'faker'

DEFAULT_ANSWERS = [
"It is certain",
"It is decidedly so",
"Without a doubt",
"Yes, definitely",
"You may rely on it",
"As I see it, yes",
"Most likely",
"Outlook good",
"Yes",
"Signs point to yes",
"Reply hazy try again",
"Ask again later",
"Better not tell you now",
"Cannot predict now",
"Concentrate and ask again",
"Don't count on it",
"My reply is no",
"My sources say no",
"Outlook not so good",
"Very doubtful"]

# User.create!(username: "Jane Doe", email: "fake@safe_email.com", hashed_password: "fake1234")

User.create(username: "JaneDoe", email: "fake@safe_email.com", password: "fake1234")

# 5.times do |x|
#   User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: Faker::Internet.password)
# end

Ball.create(name: "Default", author_id: 1)

DEFAULT_ANSWERS.each do |answer|
  Answer.create(body: answer, answerer_id: 1, ball_id: 1)
end
