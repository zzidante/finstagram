
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


#
#


    #Displaying post form
get '/posts/new' do 
        @post = Post.new
        erb(:"posts/new")
end

    #Process form submissions
post '/posts' do
    photo_url = params[:photo_url]
    
    #instantiate new Post
    @post = Post.new({ photo_url: photo_url, user_id: current_user.id })
    
    #if @post validates, save
    if @post.save
        redirect(to('/'))
    else
        
        #if it doesn't validate, print error message
        erb(:"posts/new")
    end
end


#seperate post page URL
get '/posts/:id' do 
    @post = Post.find (params[:id]) #find the post with the ID from the URL
    # escape_html @post.inspect < < < Print info to screen (demo purpose)
    erb(:"posts/show")   #render app/views/posts/show.erb 
end

post '/comments' do 
    #points values from params to variables
    text = params[:text]
    post_id = params[:post_id]
    
    #instantiate a comment with those values & assign the comment to the 'current_user'
    comment = Comment.new({text: text, post_id: post_id, user_id: current_user.id })
    
    #save the comment
    comment.save
    
    #redirect back to whereever we came from
    redirect(back)
end


post '/likes' do
    post_id=params[:post_id]
    
    like = Like.new({ post_id: post_id, user_id: current_user.id }).save 
    
        #back is Sinatra Magic
    redirect(back)
end

#
#

delete '/likes/:id' do
    like = Like.find(params[:id]) 
    like.destroy
    redirect(back)
end
