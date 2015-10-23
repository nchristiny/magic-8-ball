def find_author_ball
  @ball = Ball.find(params[:id])
  @author = User.find(@ball.author_id)
end

def redirect_non_author
  redirect '/' unless @author == current_user
end
