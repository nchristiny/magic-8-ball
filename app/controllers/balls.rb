get '/balls' do
  @balls = Ball.all
  erb :'/balls/index'
end

get '/balls/:id' do
  @ball = Ball.find(params[:id])
  user_id = @ball.user_id
  @user = User.find(user_id)

  erb :"balls/show"
end
