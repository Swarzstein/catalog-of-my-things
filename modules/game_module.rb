module GameModule
  def new_game
    genre = genre_getter
    label = label_getter
    author = author_getter
    puts "\n*- Add a game -*\n"
    print 'Is it a multiplayer game? [Y/N]: '
    multiplayer = gets.chomp.to_s.downcase == 'y'
    print 'When was it last played at? (YYYY-MM-DD): '
    last_played_at = string_to_date(gets.chomp)
    print 'Published Date (YYYY-MM-DD): '
    publish_date = string_to_date(gets.chomp)
    game = Game.new(multiplayer, last_played_at, publish_date)
    genre.add_item(game)
    label.add_item(game)
    author.add_item(game)

    @games.push(game)
    puts 'New Game created!'
  end

  def list_all_games
    if @games.empty?
      puts 'No game to display. You can add one.'
    else
      @games.each do |game|
        puts("- Publish date: #{game.publish_date} Last played: #{game.last_played_at}; "\
             "Genre: #{game.genre.name}; Label: #{game.label.title}")
      end
    end
  end

  def save_games
    game_list = []
    @games.each { |game| game_list << game_hash(game) }
    puts game_list
    File.write('./data/game.json', JSON.pretty_generate(game_list))
  end

  def game_label_adder(o_label, h_label, game)
    if o_label
      o_label.add_item(game)
    else
      new_label = Label.new(h_label['title'], h_label['color'])
      new_label.add_item(game)
      @labels << new_label
    end
  end

  def game_genre_adder(o_genre, h_genre, game)
    if o_genre
      o_genre.add_item(game)
    else
      new_genre = Genre.new(h_genre['name'])
      new_genre.add_item(game)
      @genres << new_genre
    end
  end

  def game_author_adder(o_author, h_author, game)
    if o_author
      o_author.add_item(game)
    else
      new_author = Author.new(h_author['first_name'], h_author['last_name'])
      new_author.add_item(game)
      @authors << new_author
    end
  end

  def game_loader(h_label, h_genre, h_author, game)
    o_label = @labels.find { |label| label.title == h_label['title'] && label.color == h_label['color'] }
    o_genre = @genres.find { |genre| genre.name == h_genre['name'] }
    o_author = @authors.find do |author|
      author.first_name == h_author['first_name'] && author.last_name == h_author['last_name']
    end

    game_label_adder(o_label, h_label, game)
    game_genre_adder(o_genre, h_genre, game)
    game_author_adder(o_author, h_author, game)

    @games << game
  end

  def game_pre_loader(games, labels, genres, authors)
    games.each do |h_game|
      date = h_game['publish_date']
      date_last_p = h_game['last_played_at']
      game = Game.new(h_game['multiplayer'], Date.new(date_last_p['year'], date_last_p['month'], date_last_p['day']),
                      Date.new(date['year'], date['month'], date['day']))

      h_label = labels.find { |label| label['id'] == h_game['label'] }
      h_genre = genres.find { |genre| genre['id'] == h_game['genre'] }
      h_author = authors.find { |author| author['id'] == h_game['author'] }
      game_loader(h_label, h_genre, h_author, game)
    end
  end

  def load_games
    return unless File.exist?('./data/game.json') && File.size?('./data/game.json')

    games = JSON.parse(File.read('./data/game.json'))
    labels = load_labels
    genres = load_genres
    authors = load_authors
    return unless games.length.positive?

    game_pre_loader(games, labels, genres, authors)
  end
end
