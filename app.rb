require 'sinatra/base'
require './lib/bookmarks'

class BookmarkManager < Sinatra::Base
  # ... app code here ...
  get '/' do
    "Hello world"
  end

  get '/bookmarks' do
    @list = Bookmarks.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks/save' do
    @url = params[:url]
    Bookmarks.create(@url)
    redirect '/bookmarks'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
