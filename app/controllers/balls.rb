get '/balls' do
  current_user
  @balls = Ball.all
  erb :"/balls/index"
end

get '/balls/new' do
  if current_user
    erb :"/balls/new"
  else
    redirect "login"
  end
end

post '/balls' do
  @user = current_user
  @ball = @user.balls.new(params[:ball])
  if @ball.save
    redirect "/balls/#{@ball.id}"
  else
    @errors = @ball.errors.full_messages
    erb :"balls/new"
  end
end

get '/balls/:id/result' do
  @ball = Ball.find(params[:id])
  user_id = @ball.author_id
  @author = User.find(user_id)
  if @ball.answers.count == 0
    redirect "balls/#{@ball.id}/answers"
  else
    erb :"balls/result"
  end
end

get '/balls/:id' do
  # current_user
  @ball = Ball.find(params[:id])
  # Instead of the next two lines, you could refactor to lean on the Ball associations you wrote:
  # @author = @ball.user
  # This is also happening all over your answers controller, so refactor there accordingly.
  user_id = @ball.author_id
  @author = User.find(user_id)
  erb :"balls/show"
end

put '/balls/:id' do
  @ball = Ball.find(params[:id])
  @ball.update_attributes(params[:ball])
  if @ball.save
    redirect "balls/#{@ball.id}"
  else
    @errors = @ball.errors.full_messages
    erb :"balls/edit"
  end
end

get '/balls/:id/edit' do
  @ball = Ball.find(params[:id])
  user_id = @ball.author_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  erb :"balls/edit"
end

delete '/balls/:id' do
  @ball = Ball.find(params[:id])
  user_id = @ball.author_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  ball = Ball.find(params[:id])
  ball.destroy
  redirect '/balls'
end
