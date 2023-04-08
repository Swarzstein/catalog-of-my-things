require_relative 'genre_module'
# require_relative 'label_module'
require './classes/music_album'
# require_relative 'author_module'
require 'json'

module MusicAlbumModule
  include GenreModule
  # include LabelModule
  # include AuthorModule

  # @music_albums = []

  def music_main
    # label = LabelModule.add_label_ui
    genre = get_genre
    # author = AuthorModule.add_author_ui
    print('Enter the publish date (YYYY-MM-DD): ')
    publish_date = gets.chomp
    print('Is it on SPOTIFY (Y/N)?')
    on_spotify = gets.chomp
    on_spotify = on_spotify != ('n' || 'N')
    new_album = MusicAlbum.new(Date.parse(publish_date), on_spotify)
    # new_album.add_label(label)
    # new_album.add_author(author)
    # new_album.add_genre(genre)
    genre.add_item(new_album)
    @music_albums.push(new_album)
    puts 'New Music Album created!'
  end

  def list_all_albums
    if @music_albums.empty?
      puts 'No music to display. You can add one.'
    else
      @music_albums.each do |music|
        puts(" | Title: #{music.label.title} Author: #{music.author.first_name} " \
             "#{music.author.last_name} Genre: #{music.genre.name} | ")
      end
    end
  end

  def save_music_album
    album_list = []
    @music_albums.each do |album|
      album_obj = {
        id: album.id,
        genre: album.genre.id,
        author: album.author.id,
        label: album.label.id,
        publish_date: album.publish_date,
        on_spotify: album.on_spotify
      }
      album_list << album_obj
    end
    File.write('./data/music_album.json', JSON.pretty_generate(album_list))
  end

  def load_music_album
    return unless JSON.parse(File.read('./memory/music_album.json')).any?

    JSON.parse(File.read('./memory/music_album.json')).each do |album|
      new_album = MusicAlbum.new(album['publish_date'], album['on_spotify'])
      @music_albums << new_album
    end
  end
end
