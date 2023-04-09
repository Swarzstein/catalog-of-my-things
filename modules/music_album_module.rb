module MusicAlbumModule
  def music_main
    genre = genre_getter
    label = label_getter
    author = author_getter
    print('Enter the publish date (YYYY-MM-DD): ')
    publish_date = string_to_date(gets.chomp)
    print('Is it on SPOTIFY (Y/N)?')
    on_spotify = gets.chomp
    on_spotify = on_spotify != ('n' || 'N')
    new_album = MusicAlbum.new(publish_date, on_spotify)
    genre.add_item(new_album)
    label.add_item(new_album)
    author.add_item(new_album)

    @music_albums.push(new_album)
    puts 'New Music Album created!'
  end

  def list_all_albums
    if @music_albums.empty?
      puts 'No music to display. You can add one.'
    else
      @music_albums.each do |music|
        puts("Publish Date : #{music.publish_date} ;  On Spotify: #{music.on_spotify} ; Genre: #{music.genre.name}")
      end
    end
  end

  def save_music_album
    album_list = []
    @music_albums.each { |album| album_list << album_hash(album) }
    File.write('./data/music_album.json', JSON.pretty_generate(album_list))
  end

  def album_label_adder(o_label, h_label, music_album)
    if o_label
      o_label.add_item(music_album)
    else
      new_label = Label.new(h_label['title'], h_label['color'])
      new_label.add_item(music_album)
      @labels << new_label
    end
  end

  def album_genre_adder(_o_label, _h_label, music_album)
    if o_genre
      o_genre.add_item(music_album)
    else
      new_genre = Genre.new(h_genre['name'])
      new_genre.add_item(music_album)
      @genres << new_genre
    end
  end

  def album_author_adder(o_author, h_author, music_album)
    if o_author
      o_author.add_item(music_album)
    else
      new_author = Author.new(h_author['first_name'], h_author['last_name'])
      new_author.add_item(music_album)
      @authors << new_author
    end
  end

  def music_album_loader(h_label, h_genre, h_author, music_album)
    o_label = @labels.find { |label| label.title == h_label['title'] && label.color == h_label['color'] }
    o_genre = @genres.find { |genre| genre.name == h_genre['name'] }
    o_author = @authors.find do |author|
      author.first_name == h_author['first_name'] && author.last_name == h_author['last_name']
    end

    album_label_adder(o_label, h_label, music_album)
    album_genre_adder(o_genre, h_genre, music_album)
    album_author_adder(o_author, h_author, music_album)

    @music_albums << music_album
  end

  def music_album_pre_loader(music_albums, labels, genres, authors)
    music_albums.each do |h_music_album|
      date = h_music_album['publish_date']
      music_album = MusicAlbum.new(Date.new(date['year'], date['month'], date['day']), h_music_album['on?spotify'])

      h_label = labels.find { |label| label['id'] == h_music_album['label'] }
      h_genre = genres.find { |genre| genre['id'] == h_music_album['genre'] }
      h_author = authors.find { |author| author['id'] == h_music_album['author'] }
      music_album_loader(h_label, h_genre, h_author, music_album)
    end
  end

  def load_music_albums
    return unless File.exist?('./data/music_album.json') && File.size?('./data/music_album.json')

    music_albums = JSON.parse(File.read('./data/music_album.json'))
    labels = load_labels
    genres = load_genres
    authors = load_authors
    return unless music_albums.length.positive?

    music_album_pre_loader(music_albums, labels, genres, authors)
  end
end
