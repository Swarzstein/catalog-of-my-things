module GameModule
    def new_game
      genre = genre_getter
      label = label_getter
      puts "\n*- Add a game -*\n"
      print 'Is it a multiplayer game? [Y/N]: '
      multiplayer = gets.chomp.to_s.downcase == 'y'
      print 'When was it last played at? (YYYY-MM-DD): '
      last_played_at = gets.chomp
      print 'Published Date (YYYY-MM-DD): '
      publish_date = gets.chomp
      game = Game.new(multiplayer, last_played_at, publish_date)
      genre.add_item(game)
      label.add_item(game)
  
      @games.push(game)
      puts 'New Game created!'
    end
  
    def list_all_games
      if @games.empty?
        puts 'No game to display. You can add one.'
      else
        @games.each do |game|
          puts("- Publish date: #{game.publish_date} Last played: #{game.last_played_at}; Genre: #{game.genre.name}; Label: #{game.label.title}")
        end
      end
    end
  
    def save_games
      game_list = []
      @games.each { |game| game_list << game_hash(game) }
      puts game_list
      File.write('./data/game.json', JSON.pretty_generate(game_list))
    end


    def game_loader(h_label, h_genre, game)
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
  
    def game_pre_loader(games, labels, genres)
      games.each do |h_game|
        date = h_game['publish_date']
        date_last_p = h_game['last_played_at']
        game = Game.new(h_game['multiplayer'], Date.new(date_last_p['year'], date_last_p['month'], date_last_p['day']), Date.new(date['year'], date['month'], date['day']))
  
        h_label = labels.find { |label| label['id'] == h_game['label'] }
        h_genre = genres.find { |genre| genre['id'] == h_game['genre'] }
        # h_author = authors.find { |author| author['id'] == h_music_album['author'] }
        music_album_loader(h_label, h_genre, game)
      end
    end
  
    def load_games
      return unless File.exist?('./data/game.json') && File.size?('./data/game.json')
  
      games = JSON.parse(File.read('./data/game.json'))
      labels = load_labels
      genres = load_genres
      return unless games.length.positive?
  
      game_pre_loader(games, labels, genres)
    end
  end
  