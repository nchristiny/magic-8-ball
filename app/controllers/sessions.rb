get '/users/new' do
  @user = User.new

    erb :signup
end

get '/users/:user_id' do
  @user = User.find(params[:user_id])
  @balls = User.find(params[:user_id]).balls
  erb :"users/show"
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect '/balls'
  else
    @errors = @user.errors.full_messages
    erb :signup
  end
end

post '/login' do
  @user = User.find_by(email: params[:user][:email])
  if User.authenticate(params[:user])
    session[:user_id] = @user.id
    redirect '/balls'
  else
    @error = "Invalid credentials. Please try again."
    erb :index
  end
end

delete '/logout' do
  session[:user_id] = nil
  redirect '/'
end
