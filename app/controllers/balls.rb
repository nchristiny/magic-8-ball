get '/balls' do
  current_user
  @balls = Ball.all
  erb :'/balls/index'
end

get '/balls/:id/result' do
  @ball = Ball.find(params[:id])
  # user_id = @ball.user_id
  # @user = User.find(user_id)

  erb :"balls/result"
end

get '/balls/:id' do
  current_user
  @ball = Ball.find(params[:id])
  # user_id = @ball.user_id
  # @user = User.find(user_id)

  erb :"balls/show"
end
