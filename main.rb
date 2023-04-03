require_relative 'app'

def wait
  puts "\npress enter to continue"
  gets.chomp
end

def bye
  puts "\nThank you for using this app!"
  gets.chomp
end

def items_lists(app)
  loop do
    case app.items_lists
    when 1
      app.all_books
    when 2
      app.all_albums
    when 3
      app.all_movies
    when 4
      app.all_games
    else
      break
    end
  end
end

def other_lists(app)
  loop do
    case app.other_lists
    when 1
      app.all_genres
    when 2
      app.all_labels
    when 3
      app.all_authors
    when 4
      app.all_sources
    else
      break
    end
  end
end

def add_items(app)
  loop do
    case app.add
    when 1
      list_items
    when 2
      app.add
    else
      break
    end
  end
end

def menu(app)
  loop do
    case app.menu
    when 1
      items_lists(app)
    when 2
      other_lists(app)
    when 3
      add_items(app)
    else
      break
    end
  end
end

def main
  app = App.new
  menu(app)
  bye
  system('cls')
  system('clear')
end

main
