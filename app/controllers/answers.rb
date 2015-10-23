get '/balls/:id/answers' do
  @ball = Ball.find(params[:id])
  user_id = @ball.author_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  @answers = @ball.answers
  erb :"answers/show"
end

get '/balls/:id/answers/new' do
  @ball = Ball.find(params[:id])
  user_id = @ball.author_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  erb :"answers/new"
end

post '/balls/:id/answers' do
  @ball = Ball.find(params[:id])
  user_id = @ball.author_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  @answer = Answer.new(body: params[:answer][:body], answerer_id: session[:user_id], ball_id: @ball.id)
   if @answer.save
    redirect "/balls/#{@ball.id}/answers"
  else
    @errors = @answer.errors.full_messages
    redirect "/balls/#{@ball.id}/answers/new"
  end
end

put '/balls/:id/answers/:answer_id' do
  @ball = Ball.find(params[:id])
  user_id = @ball.author_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  @answer = Answer.find(params[:answer_id])
  @answer.update_attributes(body: params[:answer][:body], answerer_id: session[:user_id], ball_id: @ball.id)
  if @answer.save
    redirect "/balls/#{@ball.id}/answers"
  else
    @errors = @answer.errors.full_messages
    erb :"answers/edit"
  end
end

get '/balls/:id/answers/:answer_id/edit' do
  @ball = Ball.find(params[:id])
  user_id = @ball.author_id
  @author = User.find(user_id)
  redirect '/' unless @author == current_user
  @answer = Answer.find(params[:answer_id])
  erb :"answers/edit"
end

delete '/balls/:id/answers/:answer_id' do
  @ball = Ball.find(params[:id])
  user_id = @ball.author_id
  @author = User.find(user_id)
  # Nice auth! I see you used it several times in this controller.
  # What about an answers.rb file in the helpers folder, with this method?
  # def authenticate_answer_author(answer)
  #   redirect '/' unless answer.user == current_user
  # end
  redirect '/' unless @author == current_user
  answer = Answer.find(params[:answer_id])
  answer.destroy
  redirect "/balls/#{@ball.id}/answers"
end
