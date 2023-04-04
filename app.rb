class App
  def clear_screen
    system('cls')
    system('clear')
  end

  def header
    clear_screen
    puts '############################'
    puts '### CATALOG OF MY THINGS ###'
    puts '############################'
  end

  def menu
    header
    puts "\nPlease choose an option by entering a number: "
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
    puts "\nPlease choose an option by entering a number: "
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
    puts "\nPlease choose an option by entering a number: "
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
    puts "\nPlease choose an option by entering a number: "
    puts '1 - add a book'
    puts '2 - add a music album'
    puts '3 - add a game'
    puts '4 - Back'
    op = gets.chomp.to_i
    add unless op <= 4 && op.positive?
    op
  end

  def all_books; end

  def all_albums; end

  def all_games; end

  def all_genres; end

  def all_labels; end

  def all_authors; end
end
