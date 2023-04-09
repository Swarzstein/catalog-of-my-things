require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'classes/music_album'
require_relative 'classes/genre'
require_relative 'classes/game'
require_relative 'classes/author'
require_relative 'modules/store'
require_relative 'modules/ui'
require_relative 'modules/book_module'
require_relative 'modules/label_module'
require_relative 'modules/genre_module'
require_relative 'modules/music_album_module'
require_relative 'modules/game_module'
require_relative 'modules/author_module'

class App
  include UI
  include Store
  include MusicAlbumModule
  include BookModule
  include GenreModule
  include LabelModule
  include GameModule
  include AuthorModule

  def initialize
    @books = []
    @music_albums = []
    @games = []
    @genres = []
    @labels = []
    @authors = []
  end

  def string_to_date(date_string)
    Date.parse(date_string)
  rescue ArgumentError
    print 'Please insert date in [YYYY-MM-DD] format'
    date_string = gets.chomp
    string_to_date(date_string)
  end

  def cover_state_getter
    print 'cover state:'
    op = gets.chomp.to_i
    case op
    when 1
      'Good'
    when 2
      'Bad'
    else
      puts 'Select a valid option'
      cover_state_getter
    end
  end

  def add_book
    header
    new_book
  end

  def add_album
    header
    music_main
    wait
  end

  def add_game
    header
    new_game
    wait
  end

  def all_books
    clear_screen
    header
    list_all_books
    wait
  end

  def all_albums
    list_all_albums
    wait
  end

  def all_games
    clear_screen
    header
    list_all_games
    wait
  end

  def all_genres
    clear_screen
    header
    list_all_genre
    wait
  end

  def all_labels
    clear_screen
    header
    list_all_labels
    wait
  end

  def all_authors
    clear_screen
    header
    list_all_authors
    wait
  end
end
