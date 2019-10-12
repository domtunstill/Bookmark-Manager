# frozen_string_literal: true

require 'sinatra/base'
require './lib/bookmark'
require './lib/comment'
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
    @bookmark_list = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks/create' do
    bookmark = Bookmark.create(url: params[:url], title: params[:title])
    if bookmark != false && params[:comment] != ""
      Comment.create(bookmark_id: bookmark.id, contents: params[:comment])
    elsif bookmark == false
      flash[:notice] = "Invalid URL"
    end
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

  get '/bookmarks/:id/comments' do
    @bookmark = Bookmark.find(id: params['id'])
    @comments = Comment.where(bookmark_id: params['id'])
    erb :'bookmarks/comments/index'
  end

  post '/bookmarks/:id/comments' do
    @comments = Comment.create(bookmark_id: params['id'], contents: params['comment'])
    redirect "/bookmarks/#{params['id']}/comments"
  end

  # delete '/bookmarks/:id/comments/:comment_id' do
  #   @comments = Comment.create(bookmark_id: params['id'], contents: params['comment'])
  #   redirect "/bookmarks/#{params['id']}/comments"
  # end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME

end
