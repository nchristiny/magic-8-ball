get '/users/new' do
  @user = User.new
    erb :"/users/signup"
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect '/balls'
  else
    @errors = @user.errors.full_messages
    erb :"users/signup"
  end
end

get '/login' do
  erb :"/login"
end

post '/login' do
  @user = User.find_by(email: params[:user][:email])
  if User.authenticate(params[:user])
    session[:user_id] = @user.id
    redirect '/balls'
  else
    @error = "Invalid credentials. Please try again."
    erb :"/login"
  end
end

delete '/logout' do
  if request.xhr?
    session[:user_id] = nil
    @current_user = nil
    redirect '/'
  end
end

get '/users/:id' do
  redirect '/' unless User.find(params[:id]) == current_user
  @user = User.find(params[:id])
  @balls = @user.balls
  erb :"users/show"
end
