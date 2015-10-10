require 'faker'

10.times do |x|
  User.create(name: Faker::Internet.user_name, email: Faker::Internet.email, hashed_password: Faker::Internet.password)
end

Ball.create(name: "Default")

["It is certain",
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
"Very doubtful"].each do |answer|
  Answer.create(body: answer)
end


