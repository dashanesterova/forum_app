require 'pg'

# this gives you a fresh global var $db to query with in pry
$db = PG.connect dbname: 'forum_app'

module FORUM_APP
  class Server < Sinatra::Base

   get '/' do
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
    post "/submit" do
      @topic = params[:topic]
      @name = @topic[:name]
      @description = @topic[:description]


     @topic = $db.exec("INSERT INTO topics (name, description, user_id) VALUES('#{@name}', '#{@description}', 1)")

     # get the topic to show up on the blanck screen
    end

    post '/comment_submit' do
    #@topic = params[:topic]
    @comment = params[:comment]
    @text = @comment[:text]
    @topic_id = params[:topic_id]



      @comments = $db.exec("INSERT INTO comments (text, topic_id) VALUES('#{@text}', '#{@topic_id}')")

      redirect "/topic/'#{@topic_id}'"
    end

  end
end
