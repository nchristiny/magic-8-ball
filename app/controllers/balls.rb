get '/balls' do
  current_user
  @balls = Ball.all
  erb :"/balls/index"
end

get '/balls/new' do
  current_user
  erb :"/balls/new"
end

# Use "post '/balls'" instead. (Newness is already implied for any object's POST controller action.)
post '/balls/new' do
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
  user_id = @ball.user_id
  @author = User.find(user_id)
  # I'm not sure what this if/else is doing...handling a case where a ball was created without any answers? Maybe that could be a validation on the Ball model. Also, I'm pretty sure the route you're redirecting to doesn't exist yet.
  if @ball.answers.count == 0
    redirect "balls/#{@ball.id}/answers"
  else
    erb :"balls/result"
  end
end

get '/balls/:id' do
  current_user
  @ball = Ball.find(params[:id])
  # Instead of the next two lines, you could refactor to lean on the Ball associations you wrote:
  # @author = @ball.user
  # This is also happening all over your answers controller, so refactor there accordingly.
  user_id = @ball.user_id
  @author = User.find(user_id)
  erb :"balls/show"
end

put '/balls/:id' do
  @ball = Ball.find(params[:id])
  # Is there any difference between #assign_attributes and #update_attributes? Look it up and find out!
  @ball.assign_attributes(params[:ball])
  if @ball.save
    redirect "balls/#{@ball.id}"
  else
    @errors = @entry.errors.full_messages
    erb :"balls/:id/edit"
  end
end

get '/balls/:id/edit' do
  @ball = Ball.find(params[:id])
  user_id = @ball.user_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  erb :"balls/edit"
end

delete '/balls/:id' do
  redirect_guests
  ball = Ball.find(params[:id])
  ball.destroy
  redirect '/balls'
end
