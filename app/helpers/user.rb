def current_user
  @user ||= User.find(session[:user_id]) if session[:user_id]
end

# def redirect_guests
#   redirect '/' unless current_user
# end