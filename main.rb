require 'sinatra'
require 'sinatra/reloader'
require 'active_support/all'
require 'active_record'

ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:host => 'localhost',
	:username => 'Sunmi',
	:password => '',
	:database => 'crud_app'
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

require_relative 'models/artist'
require_relative 'models/song'

# before any directory
before do
	# SELECT * FROM artists;
	@nav_artists = Artist.all
	@nav_songs = Song.all
end

# show homepage
get '/' do
	erb :home
end

# show all artists page
get '/artists' do
	erb :artists
end

# go to add artist form
get '/artists/new_artist' do
	erb :new_artist
end

# add new artist
post '/artists/new_artist' do
	# INSERT INTO artists (name, genre, num_members, origin) VALUES ('name', 'genre', 'num_members', 'origin');
	artist = Artist.new(params[:artist])
	artist.save!
	id = artist.id

	redirect "/artists/#{id}"
end

# show specific artist
get '/artists/:id' do
	id = params[:id]
	# SELECT * FROM artists WHERE id = id;
	@artist = Artist.find(id)

	erb :show_artist
end

# edit artist
get '/artists/:id/edit' do
	id = params[:id]
	# SELECT * FROM artists WHERE id = id;
	@artist = Artist.find(id)

	erb :edit_artist
end

# update artist
post '/artists/:id' do
	id = params[:id]

	# SELECT * FROM artists WHERE id = id;
	artist = Artist.find(id)
	# UPDATE artists
	# SET (name='name', genre='genre', num_members='num_members', origin='origin')
	# WHERE id = id;
	artist.update_attributes(params[:artist])

	redirect "/artists/#{id}"
end

# delete artist
get '/artists/:id/delete' do
	id = params[:id]
	# SELECT * FROM artists WHERE id = id;
	artist = Artist.find(id)
	# DELETE FROM artists where id = id;
	artist.delete
	artist.save!

	redirect '/artists'
end

# show form to add new song
get '/artists/:id/add_song' do
	@artist_id = params[:id]
	# SELECT * FROM artists where id = id;
	@artist = Artist.find(@artist_id)
	erb :new_song
end

# add new song to artist
post '/artists/:id/add_song' do
	id = params[:id]
	# SELECT * FROM artists where id = id;
	artist = Artist.find(id)
	# INSERT INTO songs (name, on_itunes, soundcloud_likes) VALUES ('name', 'on_itunes', 'soundcloud_likes') WHERE artist_id = id;
	artist.songs << Song.new(params[:song])

	redirect "/artists/#{id}"
end

# show specific song
get '/artists/:id/songs/:song_id' do
	id = params[:id]
	song_id = params[:song_id]

	# SELECT * FROM artists WHERE id = id;
	@artist = Artist.find(id)
	# SELECT * FROM songs WHERE id = id;
	@song = Song.find(song_id)

	erb :show_song
end

# get form to edit song
get '/artists/:id/songs/:song_id/edit' do
	id = params[:id]
	song_id = params[:song_id]

	# SELECT * FROM artists WHERE id = id;
	@artist = Artist.find(id)
	# SELECT * FROM songs WHERE id = song_id;
	@song = Song.find(song_id)

	erb :edit_song
end

#update song
post '/artists/:id/songs/:song_id' do
	id = params[:id]
	song_id = params[:song_id]
	song = Song.find(song_id)

	# UPDATE songs
	# SET (name='name', on_itunes='on_itunes', soundcloud_likes='soundcloud_likes')
	# WHERE id = song_id;
	song.update_attributes(params[:song])

	redirect "/artists/#{id}/songs/#{song_id}"
end

# delete song
get '/artists/:id/songs/:song_id/delete' do
	id = params[:id]
	song_id = params[:song_id]

	# SELECT * FROM songs WHERE id = song_id;
	song = Song.find(song_id)
	# DELETE FROM songs where id = song_id;
	song.delete
	song.save!
	
	### redirect '/artists/#{id}'
	redirect '/artists'
end

	