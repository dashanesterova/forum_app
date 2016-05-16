require 'pg'

# this gives you a fresh global var $db to query with in pry
$db = PG.connect dbname: 'forum_app'

module FORUM_APP
  require 'bcrypt'
  class Server < Sinatra::Base

    get '/login' do
      erb :login
    end


    post "/login" do
      @email = params[:email]
      @password = params[:password]

      @user = $db.exec(
        "SELECT * FROM users WHERE email=$1 LIMIT 1",
        [@email]
      ).first

      if @user && @user["password"] == params[:password]
        puts "You have successfully logged in"
        redirect "/topics"
      else
        puts "Incorrect email or password!"
        redirect "/login"
      end
    end

    get '/' do
      erb :signup
    end

    post '/signup' do
      @username = params[:username]
      @email = params[:email]
      @password = params[:password]

      if @username.length != 0 && @email.length != 0 && @password.length != 0
         $db.exec("INSERT INTO users (username, email, password) VALUES('#{@username}', '#{@email}', '#{@password}') ")
         # erb :index
         redirect 'topics'
      else
         erb :signup
      end


    end

   get '/topics' do
    #get the topics data
    @topics = $db.exec('SELECT * FROM topics')
      erb :index
    end

    get '/topic/:id' do
    #get all comments for the specific topic and the topic
    @id = params[:id]

    @comments = $db.exec("SELECT * FROM comments WHERE topic_id=#{@id}")
    @topic = $db.exec("SELECT * FROM topics WHERE id=#{@id}").first

      erb :topic
    end

    #submited for topics
    post "/topic_submit" do
      @topic = params[:topic]
      @name = @topic[:name]
      @description = @topic[:description]


     @topic = $db.exec("INSERT INTO topics (name, description, user_id) VALUES('#{@name}', '#{@description}', 1)")
     # puts 'topic?', @topic
     # @topic_id = @topic[:id]
      redirect "/topics"

     # get the topic to show up on the blanck screen
    end

    post '/comment_submit' do
    # @topic = params[:topic]
    @comment = params[:comment]
    @text = @comment[:text]
    @topic_id = params[:topic_id]



      @comments = $db.exec("INSERT INTO comments (text, topic_id) VALUES('#{@text}', '#{@topic_id}')")

      redirect "/topic/#{@topic_id}"
    end


  end
end
