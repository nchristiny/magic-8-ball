get '/users/new' do
  @user = User.new
    erb :"/users/signup"
end

# This should be "post '/users/' do" instead.
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

# REST conventions are malleable when it comes to login and logout. The next three routes could be called '/login', '/login', and '/logout' respectively, without the notion of users included. On the logout route, I'd use a "delete" action instead of a "get", since that's the type of action being carried out.

get '/users/login' do
  erb :"users/login"
end

post '/users/login' do
  @user = User.find_by(email: params[:user][:email])
  if User.authenticate(params[:user])
    session[:user_id] = @user.id
    redirect '/balls'
  else
    # Loving the vagueness of this error. A login error should never tell users whether a given email is already in the db, due to the security implications of revealing that information.
    @error = "Invalid credentials. Please try again."
    erb :"users/login"
  end
end

get '/users/logout' do
  session[:user_id] = nil
  redirect '/'
end

# Nice work recognizing that a show route for a user is also kind of like an index route for all of that user's balls.
get '/users/:id' do
  redirect '/' unless User.find(params[:id]) == current_user
  @user = User.find(params[:id])
  @balls = @user.balls
  erb :"users/show"
end
