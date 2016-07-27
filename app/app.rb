ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :'hello'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
                password: params[:password])
    session[:user_id] = user.id
    redirect to('/links')
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tag].split.each do |tag|
      link.tag << Tag.create(name: tag)
    end
    link.save
    redirect to('/links')
  end

  get '/tag/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
