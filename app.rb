require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'classes/music_album'
require_relative 'classes/genre'
require_relative 'classes/game'
require_relative 'modules/store'
require_relative 'modules/ui'
require_relative 'modules/book_module'
require_relative 'modules/label_module'
require_relative 'modules/genre_module'
require_relative 'modules/music_album_module'
require_relative 'modules/game_module'

class App
  include UI
  include Store
  include MusicAlbumModule
  include BookModule
  include GenreModule
  include LabelModule
  include GameModule

  def initialize
    @books = []
    @music_albums = []
    @games = []
    @genres = []
    @labels = []
    @authors = []
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

  def all_authors; end

  # saving and loading data
  def save_data
    puts 'Data saved successfully !!! CONGRATS'
  end

  def load_data
    GenreModule.load_genre
    puts 'Data loaded sucessfully !!! CONGRATS'
  end
end
