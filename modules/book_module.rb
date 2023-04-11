module BookModule
  def new_book_creator(book)
    label = label_getter
    genre = genre_getter
    author = author_getter
    label.add_item(book)
    genre.add_item(book)
    author.add_item(book)
    @books << book
  end

  def new_book
    puts "Creating new book\n"
    print 'Publisher: '
    publisher = gets.chomp
    puts 'select cover state:'
    puts '[1] Good'
    puts '[2] Bad'
    cover_state = cover_state_getter
    puts '-Published date-'
    print 'Year: '
    year = gets.chomp.to_i
    print 'Month: '
    month = gets.chomp.to_i
    print 'Day: '
    day = gets.chomp.to_i
    book = Book.new(publisher, cover_state, Date.new(year, month, day))
    new_book_creator(book)
  end

  def list_all_books
    if @books.length >= 1
      @books.each_with_index do |book, i|
        puts "#{i + 1} - Title: #{book.label.title}, Author: #{book.author.first_name} " \
             "#{book.author.last_name}, Publisher: #{book.publisher}, Publish date: #{book.publish_date}"
      end
    else
      puts "There's no book registered"
    end
  end

  def save_books
    hash_arr = []
    @books.each { |book| hash_arr << book_hash(book) }
    File.write('./data/books.json', JSON.pretty_generate(hash_arr))
  end

  def book_label_adder(o_label, h_label, book)
    if o_label
      o_label.add_item(book)
    else
      new_label = Label.new(h_label['title'], h_label['color'])
      new_label.add_item(book)
      @labels << new_label
    end
  end

  def book_genre_adder(o_genre, h_genre, book)
    if o_genre
      o_genre.add_item(book)
    else
      new_genre = Genre.new(h_genre['name'])
      new_genre.add_item(book)
      @genres << new_genre
    end
  end

  def book_author_adder(o_author, h_author, book)
    if o_author
      o_author.add_item(book)
    else
      new_author = Author.new(h_author['first_name'], h_author['last_name'])
      new_author.add_item(book)
      @authors << new_author
    end
  end

  def book_loader(h_label, h_genre, h_author, book)
    o_label = @labels.find { |label| label.title == h_label['title'] && label.color == h_label['color'] }
    o_genre = @genres.find { |genre| genre.name == h_genre['name'] }
    o_author = @authors.find do |author|
      author.first_name == h_author['first_name'] && author.last_name == h_author['last_name']
    end

    book_label_adder(o_label, h_label, book)
    book_genre_adder(o_genre, h_genre, book)
    book_author_adder(o_author, h_author, book)
    @books << book
  end

  def book_pre_loader(books, labels, genres, authors)
    books.each do |h_book|
      date = h_book['publish_date']
      book = Book.new(h_book['publisher'], h_book['cover_state'], Date.new(date['year'], date['month'], date['day']))

      h_label = labels.find { |label| label['id'] == h_book['label'] }
      h_genre = genres.find { |genre| genre['id'] == h_book['genre'] }
      h_author = authors.find { |author| author['id'] == h_book['author'] }
      book_loader(h_label, h_genre, h_author, book)
    end
  end

  def load_books
    return unless File.exist?('data/books.json') && File.size?('data/books.json')

    books = JSON.parse(File.read('data/books.json'))
    labels = load_labels
    genres = load_genres
    authors = load_authors
    return unless books.length.positive?

    book_pre_loader(books, labels, genres, authors)
  end
end
