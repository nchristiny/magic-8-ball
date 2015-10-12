get '/users/new' do
  @user = User.new
    erb :"/users/signup"
end

post '/users/new' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect '/balls'
  else
    @errors = @user.errors.full_messages
    erb :"users/signup"
  end
end

get '/users/login' do
  erb :"users/login"
end

post '/users/login' do
  @user = User.find_by(email: params[:user][:email])
  if User.authenticate(params[:user])
    session[:user_id] = @user.id
    redirect '/balls'
  else
    @error = "Invalid credentials. Please try again."
    erb :"users/login"
  end
end

get '/users/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/users/:user_id' do
  redirect '/' unless User.find(params[:user_id]) == current_user
  @user = User.find(params[:user_id])
  @balls = @user.balls
  erb :"users/show"
end
