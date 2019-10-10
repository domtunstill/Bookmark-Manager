# frozen_string_literal: true

require 'sinatra/base'
require './lib/bookmark'
require './database_connection_setup.rb'
require 'sinatra/flash'

# class

class BookmarkManager < Sinatra::Base
  # ... app code here ...
  enable :method_override, :sessions
  register Sinatra::Flash

  get '/' do
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @list = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks/create' do
    flash[:notice] = "Invalid URL" unless Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id/delete' do
    Bookmark.delete(id: params['id'])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/update' do
    @bookmark = Bookmark.find(id: params['id'])
    erb :'bookmarks/update'
  end

  patch '/bookmarks/:id/update' do
    Bookmark.update id: params['id'], title: params['title'], url: params['url']
    redirect '/bookmarks'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME

end
