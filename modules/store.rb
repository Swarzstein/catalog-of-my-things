require 'date'
require 'json'

module Store
  def book_hash(book)
    {
      id: book.id,
      genre: book.genre&.id,
      author: book.author&.id,
      label: book.label&.id,
      publish_date: {
        year: book.publish_date.year,
        month: book.publish_date.month,
        day: book.publish_date.day
      },
      archived: book.archived,
      publisher: book.publisher,
      cover_state: book.cover_state
    }
  end

  def label_hash(label)
    items = []
    label.items.each do |item|
      items << { id: item.id, class: item.class.name }
    end
    {
      id: label.id,
      title: label.title,
      color: label.color,
      items: items
    }
  end

  def genre_hash(genre)
    items = []
    genre.items.each do |item|
      items << { id: item.id, class: item.class.name }
    end
    {
      id: genre.id,
      name: genre.name,
      items: items
    }
  end

  def save_books
    hash_arr = []
    @books.each do |book|
      hash_arr << book_hash(book)
    end
    File.open('data/books.json', 'w') { |s| s << hash_arr.to_json }
  end

  def save_labels
    hash_arr = []
    @labels.each do |label|
      hash_arr << label_hash(label)
    end
    File.open('data/labels.json', 'w') { |s| s << hash_arr.to_json }
  end

  def save_genre
    genre_list = []
    @genres.each do |genre|
      genre_list << genre_hash(genre)
    end
    File.write('data/genre.json', JSON.pretty_generate(genre_list))
  end

  def load_labels
    return [] unless File.exist?('data/labels.json') && File.size?('data/labels.json')

    JSON.parse(File.read('data/labels.json'))
  end

  def loader(books, labels)
    books.each do |h_book|
      date = h_book['publish_date']
      book = Book.new(h_book['publisher'], h_book['cover_state'], Date.new(date['year'], date['month'], date['day']))

      h_label = labels.find { |label| label['id'] == h_book['label'] }
      o_label = @labels.find { |label| label.title == h_label['title'] && label.color == h_label['color'] }

      if o_label
        o_label.add_item(book)
        @books << book
      else
        new_label = Label.new(h_label['title'], h_label['color'])
        new_label.add_item(book)
        @books << book
        @labels << new_label
      end
    end
  end

  def load_books
    return unless File.exist?('data/books.json') && File.size?('data/books.json')

    books = JSON.parse(File.read('data/books.json'))
    labels = load_labels
    return unless books.length.positive?

    loader(books, labels)
  end

  def load_genre
    return unless File.exist?('data/genre.json') && File.size?('data/genre.json')

    JSON.parse(File.read('data/genre.json')).each do |genre|
      new_genre = Genre.new(genre['name'])
      new_genre.id = genre['id']
      @genres << new_genre
    end
  end

  def save
    save_books
    save_labels
    save_genre
  end

  def load
    load_books
    load_genre
  end
end
