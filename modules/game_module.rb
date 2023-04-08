module GameModule
    def new_game
      genre = genre_getter
      label = label_getter
      print('Enter the publish date (YYYY-MM-DD): ')
      publish_date = gets.chomp
      print('Is it on SPOTIFY (Y/N)?')
      on_spotify = gets.chomp
      on_spotify = on_spotify != ('n' || 'N')
      new_album = Game.new(Date.parse(publish_date), on_spotify)
      genre.add_item(new_album)
      label.add_item(new_album)
  
      @games.push(new_album)
      puts 'New Music Album created!'
    end
  
    def list_all_games
      if @games.empty?
        puts 'No music to display. You can add one.'
      else
        @games.each do |music|
          puts("Publish Date : #{music.publish_date} ;  On Spotify: #{music.on_spotify} ; Genre: #{music.genre.name}")
        end
      end
    end
  
    def save_music_album
      album_list = []
      @games.each { |album| album_list << album_hash(album) }
      puts album_list
      File.write('./data/game.json', JSON.pretty_generate(album_list))
    end

    def music_album_loader(h_label, h_genre, game)
      o_label = @labels.find { |label| label.title == h_label['title'] && label.color == h_label['color'] }
      o_genre = @genres.find { |genre| genre.name == h_genre['name'] }
  
      if o_label
        o_label.add_item(game)
      else
        new_label = Label.new(h_label['title'], h_label['color'])
        new_label.add_item(game)
        @labels << new_label
      end
  
      if o_genre
        o_genre.add_item(game)
      else
        new_genre = Genre.new(h_genre['name'])
        new_genre.add_item(game)
        @genres << new_genre
      end
  
      @games << game
    end
  
    def music_album_pre_loader(games, labels, genres)
      games.each do |h_music_album|
        date = h_music_album['publish_date']
        game = Game.new(Date.new(date['year'], date['month'], date['day']), h_music_album['on?spotify'])
  
        h_label = labels.find { |label| label['id'] == h_music_album['label'] }
        h_genre = genres.find { |genre| genre['id'] == h_music_album['genre'] }
        # h_author = authors.find { |author| author['id'] == h_music_album['author'] }
        music_album_loader(h_label, h_genre, game)
      end
    end
  
    def load_music_albums
      return unless File.exist?('./data/game.json') && File.size?('./data/game.json')
  
      games = JSON.parse(File.read('./data/game.json'))
      labels = load_labels
      genres = load_genres
      return unless games.length.positive?
  
      music_album_pre_loader(games, labels, genres)
    end
  end
  