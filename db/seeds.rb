require 'faker'

DEFAULT_ANSWERS = ["It is certain",
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

default_user = User.create(username: "Jane Doe", email: "fake@safe_email.com", hashed_password: "fake1234")

5.times do |x|
  User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, hashed_password: Faker::Internet.password)
end

Ball.create(name: "Default", user_id: 1)

DEFAULT_ANSWERS.each do |answers|
  Answer.create(body: answers, user_id: 1, ball_id: 1)
end
