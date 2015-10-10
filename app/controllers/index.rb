get '/' do
  @balls = Ball.all
  erb :"balls/index"
end