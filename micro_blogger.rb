require './twitter_init.rb'
require 'bitly'
require 'klout'

class MicroBlogger
    attr_reader :client
    
    def initialize
        puts "Initializing..."
        @client = AnujaTwitter.new.client
        puts @client.inspect
        #Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
    end
    def tweet(message)
        @client.update(message)
    end
    def follow(users)
        @client.follow(users)
    end
    def user(users)
        @client.user(users)
    end
    def followers(users)
        @client.followers(users)
        screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
        puts screen_names
    end
    
    def friends(users)
        @client.friends(users)
    end
    def user_timeline(users)
        @client.user_timeline(users)
    end
    def search
        @client.search("to:justinbieber marry me", result_type: "recent").take(3).collect do |tweet|
        "#{tweet.user.screen_name}: #{tweet.text}"
        end
    end
    #def search
    #    @client.search("#ruby -rt", lang: "ja").first.text
    #end
    def run
        puts "Welcome to the JSL Twitter Client!"
        command = " "
        while command != "q"
            print "Enter command: "
            input = gets.chomp
            parts = input.split(" ")
            command = parts[0]
            case command
            when 'q' then puts "Goodbye!"
            when "a" then puts "It is an A!"
            when "b" then puts "It is a B!"
            when "c" then puts "It is a C!"
            when "t" then tweet(parts[1..-1].join(" "))
            when "dm" then dm(parts[1], parts[2..-1].join(" "))
            when "flt" then friends_last_tweet
            when "s" then shorten
            #when "turl" then puts "I wrote this twitter client at: #{shorten(tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1])))}"
            when "k" then klout_score
            else
              puts "Sorry, I don't know the command #{command}"
            end           
        end
    end

    def dm(target, message)
        puts "Trying to send #{target}, this direct message:"
        puts message
        message = "@#{target} #{message}"
        tweet(message)
    end

    def friends_last_tweet
        friends = @client.friends
        friends.each do |friend|
            friend.status
            fs = friend.status
            puts fs.inspect          
        end
    end
    def shorten
        Bitly.use_api_version_3
        bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
        puts bitly.shorten('http://jumpstartlab.com/courses/').inspect
        #puts "Shortening this URL: #{original_url}"
    end
    def klout_score     
        friends = @client.friends.collect { |friend| @client.user(friend).screen_name}
        puts friends
        #Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
        #identity = Klout::Identity.find_by_screen_name('gem')
        #user = Klout::User.new(identity.id)
        #user.score.score
        
    end
end
blogger = MicroBlogger.new
blogger.tweet("MicroBlogger Initialized Today") #tweets
blogger.follow("elonmusk") #follow a user
blogger.user("iamsrk") #fetch a user
blogger.followers("AnujaSh44221827") #fetch cursored list of followers
blogger.friends("AnujaSh44221827") #fetch cursored list of friends with profile details
blogger.user_timeline("iamsrk") #fetch the timeline of tweets by a user
puts blogger.search #search justin beiber's 3 latest marriage proposals
puts blogger.run
blogger.dm
puts blogger.friends_last_tweet
