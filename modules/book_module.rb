module BookModule
  def get_cover_state
    print 'cover state:'
    op = gets.chomp.to_i
    case op
    when 1
      'Good'
    when 2
      'bad'
    else
      puts 'Select a valid option'
      get_cover_state
    end
  end
  
  def new_book
    puts "Creating new book\n"
    print 'Publisher: '
    publisher = gets.chomp
    puts "select cover state:"
    puts "[1] Good"
    puts "[2] Bad"
    cover_state = get_cover_state
    puts '-Published date-'
    print 'Year: '
    year = gets.chomp.to_i
    print 'Month: '
    month = gets.chomp.to_i
    print 'Day: '
    day = gets.chomp.to_i
    book = Book.new(publisher, cover_state, Date.new(year, month, day))
    label = get_label
    genre = get_genre
    label.add_item(book)
    genre.add_item(book)
    @books << book
  end

  def list_all_books
    if @books.length >= 1
      @books.each_with_index do |book, i|
        puts "#{i + 1} - Title: \"#{book.label.title}\", Author: \"author\", Publisher: \"#{book.publisher}\", " \
             "Publish date: \"#{book.publish_date}\""
      end
    else
      puts "There's no book registered"
    end
  end
end
