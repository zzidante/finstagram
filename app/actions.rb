
helpers do  
    def current_user
        User.find_by(id: session[:user_id])
    end
end

#LOGIC BEHIND POST TIME_AGO_IN_MINUTES
def humanized_time_ago(time_ago_in_minutes)
        
    #   and if it's exactly 60 minutes
    if time_ago_in_minutes == 60
    #
    #   return this string
        "#{time_ago_in_minutes / 60} hour ago"
        
        
    #   if time_ago_in_minutes is more than 60
    elsif time_ago_in_minutes >= 99 
    #   
    #   return this string
        "#{time_ago_in_minutes / 60} hours ago"
            

    #   and if it's equal to 1 minute or less
    elsif time_ago_in_minutes <= 1
    #
    #   return this string
        "just a moment ago"
            
    
    #   if it's less than or equal to time_ago_in_minutes
    else
    #
    #   return this string instead.
        "#{time_ago_in_minutes} minutes ago"
    end    
end

#ORDER POSTS BY POST DATE
get '/' do
    @posts = Post.order(created_at: :desc)
    erb(:index)
end


#CREATE NEW USER FROM FORM
get '/signup' do
    @user = User.new
    erb(:signup)
end

#FORM LOGIC
post '/signup' do  
    #grab user input values from params
    email = params[:email]
    avatar_url = params[:avatar_url]
    username = params[:username]
    password = params[:password]

    #instatiate and save a User
    @user=User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

    if @user.save 
        redirect to('/login')
        
    #redirect to login page
     ###escape_html user.inspect
    
    else 
    
    #display error message
        erb(:signup)   
    end
end

get '/login' do    #When a GET request come into /login
    erb(:login)     #render app/views/login.erb
end

post '/login' do    
    username = params[:username] 
    password = params[:password]
    
    user = User.find_by(username: username)  # 1.Find user by username
    
    if user && user.password == password #and the password matches
        session[:user_id] = user.id
            redirect to('/')
        else
            @error_message = "Login Failed :("
            erb(:login)
    end
end

get '/logout' do
    session[:user_id] = nil
    redirect to('/')
end

