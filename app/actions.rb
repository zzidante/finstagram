
def humanized_time_ago(time_ago_in_minutes)
        
    #   and if it's exactly 60 minutes
    if time_ago_in_minutes == 60
    #
    #   return this string
        "#{time_ago_in_minutes / 60} hour ago"
        
        
    #   if time_ago_in_minutes is more than 60
    elsif time_ago_in_minutes >= 120 
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

get '/' do
    
    @post_shark = {
        username: "sharkey_j",
        avatar_url: "http://naserca.com/images/sharky_j.jpg",
        photo_url: "http://naserca.com/images/shark.jpg",
        humanized_time_ago: humanized_time_ago(15),
        like_count: 0,
        comment_count: 1,
        comments: [{
            username: "sharkey_j",
            text: "Out for the long weekend... too embarassed to show y'all the beach bod!"
        }]
    }
    
    
    @post_mass_fx = {
        username: "Mass_FX",
        avatar_url: "https://i2.wp.com/ashraf62.files.wordpress.com/2014/09/king-tutankhamen.jpg?resize=40%2C40&ssl=1",
        photo_url: "http://www.masseffect-game.de/sites/www.masseffect-game.de/files/styles/media_gallery_thumbnail/public/me3_leviathan_20120803_04.jpg?itok=iPNecDgY",
        humanized_time_ago: humanized_time_ago(60),
        like_count: 0,
        comment_count: 0,
        comments: [{
            username: "Mass_FX",
            text: "I sunk your battleship bro."
        }]
    }
    
     @post_nervuspkmn = {
        username: "NervusPKMN",
        avatar_url: "http://www.stylepoints.org/arrgh!/Themes/backnblack_204/images/pirate.gif",
        photo_url: "https://media-cdn.tripadvisor.com/media/photo-s/04/a8/a5/69/siam-ocean-world.jpg",
        humanized_time_ago: humanized_time_ago(100),
        like_count: 0,
        comment_count: 0,
        comments: [{
            username: "NervusPKMN",
            text: "Should I really say something?"
        }]
    }
    #humanized_time_ago(post[:time_ago_in_minutes])
    [@post_shark, @post_mass_fx, @post_nervuspkmn].to_s


    #calling erb method (built into Sinatra/Ruby) passing it a single argument erb(:index)
    #single arguments can be called WITHOUT Methods(:argument) < symbol. Instead Methods:argument. 
    erb:index 
end