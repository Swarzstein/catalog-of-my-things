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
    @music_albums.each { |album| album_list << album_hash(album) }
    File.write('./data/music_album.json', JSON.pretty_generate(album_list))
  end

  # def load_music_album
  #   return unless JSON.parse(File.read('./memory/music_album.json')).any?

  #    JSON.parse(File.read('./memory/music_album.json')).each do |album|
  #      new_album = MusicAlbum.new(album['publish_date'], album['on_spotify'])
  #      @music_albums << new_album
  #    end
  #  end
  def music_album_loader(h_label, h_genre, music_album)
    o_label = @labels.find { |label| label.title == h_label['title'] && label.color == h_label['color'] }
    o_genre = @genres.find { |genre| genre.name == h_genre['name'] }

    if o_label
      o_label.add_item(music_album)
      @music_albums << music_album
    else
      new_label = Label.new(h_label['title'], h_label['color'])
      new_label.add_item(music_album)
      @labels << new_label
    end

    if o_genre
      o_genre.add_item(music_album)
      @music_albums << music_album
    else
      new_genre = Genre.new(h_genre['name'])
      new_genre.add_item(music_album)
      @genres << new_genre
    end

    @music_albums << music_album
  end

  def music_album_pre_loader(music_albums, labels, genres)
    music_albums.each do |h_music_album|
      date = h_music_album['publish_date']
      music_album = MusicAlbum.new(Date.new(date['year'], date['month'], date['day']), h_music_album['on?spotify'])

      h_label = labels.find { |label| label['id'] == h_music_album['label'] }
      h_genre = genres.find { |genre| genre['id'] == h_music_album['genre'] }
      # h_author = authors.find { |author| author['id'] == h_music_album['author'] }
      music_album_loader(h_label, h_genre, music_album)
    end
  end

  def load_music_albums
    return unless File.exist?('data/music_albums.json') && File.size?('data/music_albums.json')

    music_albums = JSON.parse(File.read('data/music_albums.json'))
    labels = load_labels
    genres = load_genres
    return unless music_albums.length.positive?

    music_album_pre_loader(music_albums, labels, genres)
    list_all_music_albums
    wait
  end
end
