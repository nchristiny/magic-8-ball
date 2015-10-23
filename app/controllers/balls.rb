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
  @ball = current_user.balls.new(params[:ball])
  if @ball.save
    redirect "/balls/#{@ball.id}"
  else
    @errors = @ball.errors.full_messages
    erb :"balls/new"
  end
end

get '/balls/:id/result' do
  find_author_ball
  if @ball.answers.count == 0
    redirect "balls/#{@ball.id}/answers"
  else
    if request.xhr?
      erb :"balls/_result", { layout: false, locals: { ball: @ball } }
    else
      erb :"balls/result"
    end
  end
end

get '/balls/:id' do
  find_author_ball
  if @ball.answers.count == 0
    redirect "balls/#{@ball.id}/answers"
  elsif request.xhr?
    erb :"balls/_result", { layout: false, locals: { ball: @ball } }
  else
    erb :"balls/show"
  end
end

put '/balls/:id' do
  find_author_ball
  redirect_non_author
  @ball.update_attributes(params[:ball])
  if @ball.save
    redirect "balls/#{@ball.id}"
  else
    @errors = @ball.errors.full_messages
    erb :"balls/edit"
  end
end

get '/balls/:id/edit' do
  find_author_ball
  redirect_non_author
  erb :"balls/edit"
end

delete '/balls/:id' do
  find_author_ball
  redirect_non_author
  ball = Ball.find(params[:id])
  ball.destroy
  redirect '/balls'
end
