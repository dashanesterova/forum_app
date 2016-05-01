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
    post '/topic' do
    #putting new topic into a database

      erb :topic
    end

    post '/comment' do
    #making comment on the same page
      erb :topic
    end

    post "/submit" do
      @topic = params[:topic]

      @comments = $db.exec("INSERT INTO topics VALUES(80,'UA502', 'Bananas', 1)")

    end

  end
end
