enable :sessions # This is already  happening in config/environment.rb, on line 36. I don't think it needs to happen again here. See what happens if you take it out.

get '/' do
  redirect "/balls"
end
