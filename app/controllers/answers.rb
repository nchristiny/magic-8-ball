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

# You can take the "/new" off this post route url.
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
    # I smell some hot and savory copypasta! What the heck is an @entry, anyhow? ;)
    # Always manually re-type a resource you're reusing in a new context, since it'll help you think through what you're adding 
    @errors = @entry.errors.full_messages
    # If the put was unsuccessful, you'll want to rerender answers/edit here instead of redirecting. The @ball object hasn't hit the db in your else case, so any changes to it would be lost in a new route. Stay here and make sure they can see the offending strings they wrote in the fields that need changing.
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
