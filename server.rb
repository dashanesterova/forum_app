require 'pg'

# this gives you a fresh global var $db to query with in pry
$db = PG.connect dbname: 'forum_app'

module FORUM_APP
  class Server < Sinatra::Base
  end
end
