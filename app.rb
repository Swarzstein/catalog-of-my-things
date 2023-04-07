require_relative 'classes/book'
require_relative 'classes/label'
require_relative 'modules/store'

class App
  include Store

  attr_reader :books, :labels

  def initialize
    @books = []
    @labels = []
  end

  def wait
    puts "\npress enter to continue"
    gets.chomp
  end

  def clear_screen
    # system('cls')
    system('clear')
  end

  def header
    clear_screen
    puts '############################'
    puts '### CATALOG OF MY THINGS ###'
    puts "############################\n\n"
  end

  def menu
    header
    puts 'Please choose an option by entering a number: '
    puts '1 - See Lists of items'
    puts '2 - See other Lists'
    puts '3 - Add items'
    puts '4 - Exit'
    op = gets.chomp.to_i
    menu unless op <= 4 && op.positive?
    op
  end

  def items_lists
    header
    puts 'Please choose an option by entering a number: '
    puts '1 - List all books'
    puts '2 - List all music albums'
    puts '3 - List of games'
    puts '4 - Back'
    op = gets.chomp.to_i
    items_lists unless op <= 4 && op.positive?
    op
  end

  def other_lists
    header
    puts 'Please choose an option by entering a number: '
    puts '1 - List all genres'
    puts '2 - List all labels'
    puts '3 - List all authors'
    puts '4 - Back'
    op = gets.chomp.to_i
    others_lists unless op <= 4 && op.positive?
    op
  end

  def add
    header
    puts 'Please choose an option by entering a number: '
    puts '1 - add a book'
    puts '2 - add a music album'
    puts '3 - add a game'
    puts '4 - Back'
    op = gets.chomp.to_i
    add unless op <= 4 && op.positive?
    op
  end

  def add_book
    header
    puts "Creating new book\n"
    print 'Title: '
    title = gets.chomp
    print 'Publisher: '
    publisher = gets.chomp
    print 'Cover state: '
    cover_state = gets.chomp
    puts '-Published date-'
    print 'Year: '
    year = gets.chomp.to_i
    print 'Month: '
    month = gets.chomp.to_i
    print 'Day: '
    day = gets.chomp.to_i
    book = Book.new(publisher, cover_state, Date.new(year, month, day))
    label = Label.new(title, 'default')
    @labels << label
    label.add_item(book)
    @books << book
  end

  def add_album
    puts 'Add an album'
  end

  def add_game
    puts 'Add a new Game'
  end

  def all_books
    clear_screen
    header
    if @books.length >= 1
      @books.each_with_index do |book, i|
        puts "#{i + 1} - Title: \"#{book.label.title}\", Author: \"author\", Publisher: \"#{book.publisher}\", " \
             "Publish date: \"#{book.publish_date}\""
      end
    else
      puts "There's no book registered"
    end
    wait
  end

  def all_albums; end

  def all_games; end

  def all_genres; end

  def all_labels
    clear_screen
    header
    if @labels.length >= 1
      @labels.each_with_index do |label, i|
        puts "#{i + 1} - Title: \"#{label.title}\", Color: \"#{label.color}\" "
        puts 'items'
        puts label.items
      end
    else
      puts "There's no label registered"
    end
    wait
  end

  def all_authors; end
end
