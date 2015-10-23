get '/balls/:id/answers' do
  find_author_ball
  redirect_non_author
  @answers = @ball.answers
  erb :"answers/show"
end

get '/balls/:id/answers/new' do
  find_author_ball
  redirect_non_author
  erb :"answers/new"
end

post '/balls/:id/answers' do
  find_author_ball
  redirect_non_author
  @answer = Answer.new(body: params[:answer][:body], answerer_id: session[:user_id], ball_id: @ball.id)
   if @answer.save
    redirect "/balls/#{@ball.id}/answers"
  else
    @errors = @answer.errors.full_messages
    redirect "/balls/#{@ball.id}/answers/new"
  end
end

put '/balls/:id/answers/:answer_id' do
  find_author_ball
  redirect_non_author
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
  find_author_ball
  redirect_non_author
  @answer = Answer.find(params[:answer_id])
  erb :"answers/edit"
end

delete '/balls/:id/answers/:answer_id' do
  find_author_ball
  redirect_non_author
  answer = Answer.find(params[:answer_id])
  answer.destroy
  redirect "/balls/#{@ball.id}/answers"
end
