# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base

  get '/' do
    # The erb method takes the view file name (as a Ruby symbol)
    # and reads its content so it can be sent 
    # in the response.
    return erb(:index)
  end

  get '/hello' do
    # Set an instance variable in the route block.
    @name = params[:name]

    # The process is then the following:
    #
    # 1. Ruby reads the .erb view file
    # 2. It looks for any ERB tags and replaces it by their final value
    # 3. The final generated HTML is sent in the response

    return erb(:index)
  end
  
  post '/albums' do 
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)

    return ''
  end

  get '/albums' do
   repo = AlbumRepository.new
   @albums = repo.all

   return erb(:all_albums)
  end

  #get '/artists' do
   # repo = ArtistRepository.new
    #artists = repo.all
 
    #response = artists.map do|artist|
    # artist.name
    #end.join(', ')
    #return response
   #end

  #get '/artists' do 
   # name = params[:name]

    #return "#{name}"
  #end

  post '/artists' do 
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo.create(new_artist)

    return ''
  end

  get '/albums/new' do
    return erb(:new_album)
  end

  get '/artists/new' do
    return erb(:new_artist)
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)
    return erb(:albums)
  end

  get '/artists/:id' do
    artist_repo = ArtistRepository.new
    @artists = artist_repo.find(params[:id])
    return erb(:artists)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
 
    return erb(:all_artists)
  end
end