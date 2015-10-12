get '/balls/:id/answers' do
  @ball = Ball.find(params[:id])
  user_id = @ball.user_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  @answers = @ball.answers
  erb :"answers/show"
end

get '/balls/:id/answers/new' do
  @ball = Ball.find(params[:id])
  user_id = @ball.user_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  erb :"answers/new"
end

post '/balls/:id/answers/new' do
  @ball = Ball.find(params[:id])
  user_id = @ball.user_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  @answer = Answer.new(body: params[:answer][:body], user_id: session[:user_id], ball_id: @ball.id)
   if @answer.save
    redirect "/balls/#{@ball.id}/answers"
  else
    @errors = @answer.errors.full_messages
    redirect "/balls/#{@ball.id}/answers/new"
  end
end

put '/balls/:id/answers/:answer_id' do
  @ball = Ball.find(params[:id])
  user_id = @ball.user_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  p params
  @answer = Answer.find(params[:answer_id])
  @answer.update_attributes(body: params[:answer][:body], user_id: session[:user_id], ball_id: @ball.id)
  if @ball.save
    redirect "/balls/#{@ball.id}/answers"
  else
    @errors = @entry.errors.full_messages
    redirect "balls/#{@ball.id}/answers/edit"
  end
end

get '/balls/:id/answers/:answer_id/edit' do
  @ball = Ball.find(params[:id])
  user_id = @ball.user_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  @answer = Answer.find(params[:answer_id])
  erb :"answers/edit"
end

delete '/balls/:id/answers/:answer_id' do
  @ball = Ball.find(params[:id])
  user_id = @ball.user_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  answer = Answer.find(params[:answer_id])
  answer.destroy
  redirect "/balls/#{@ball.id}/answers"
end
