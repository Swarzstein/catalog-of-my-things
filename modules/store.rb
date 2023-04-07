require 'date'
require 'json'

module Store
  def save_data
    save_books
  end

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

  def save_books
    hash_arr = []
    @books.each do |book|
      hash_arr << book_hash(book)
    end
    File.open('storage/books.json', 'w') { |s| s << hash_arr.to_json }
    puts 'saving books'
    puts hash_arr
  end

  def save_labels
    hash_arr = []
    @labels.each do |label|
      hash_arr << label_hash(label)
    end
    File.open('storage/labels.json', 'w') { |s| s << hash_arr.to_json }
    puts 'saving data'
    puts hash_arr
  end

  def load_books
    return unless File.exist?('storage/books.json') && File.size?('storage/books.json')

    books = []
    storage = JSON.parse(File.read('storage/books.json'))
    storage.map do |book|
      books.push(Book.new(book['publisher'], book['cover_state'], book['publish_date']))
    end
    books
  end

  def load_labels
    return [] unless File.exist?('storage/labels.json') && File.size?('storage/labels.json')

    JSON.parse(File.read('storage/labels.json'))
    # puts 'loading data'
    # puts storage
    # labels = []
    # storage.map do |label|
    #   labels.push(Label.new(label[:title], label[:color]))
    # end
    # labels
  end

  def loader; end

  def load_data
    return unless File.exist?('storage/books.json') && File.size?('storage/books.json')

    books = JSON.parse(File.read('storage/books.json'))
    labels = load_labels
    return unless books.length.positive?

    books.each do |h_book|
      puts h_book
      date = h_book['publish_date']
      puts "date is #{date}"
      puts 'Hello'
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

  def load
    return unless File.exist?('storage/labels.json') && File.size?('storage/labels.json')

    labels = JSON.parse(File.read('storage/labels.json'))

    labels.each do |h_label|
      label = Label.new(h_label['title'], h_label['color'])
      h_label['items'].each do |h_item|
        next unless h_item['class'] == 'Book'

        label.add_item(load_books.find { |book| book.id == h_item['id'] })
        @books << book
      end
    end
  end

  def save
    save_books
    save_labels
  end

  def load(books, labels)
    @labels.each do |label|
      label.items.each { |item| item.label = label }
    end
    load_books(books)
    load_labels(labels)
  end
end
