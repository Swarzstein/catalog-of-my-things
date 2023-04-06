require 'date'
require 'json'

module Store
  def save_data
    save_books
  end

  def to_hash(book)
    {
      id: book.id,
      genre: book.genre,
      author: book.author,
      label: book.label,
      publish_date: book.publish_date,
      archived: book.archived,
      publisher: book.publisher,
      cover_state: book.cover_state
    }
  end

  

  

  def save(books, labels)
    def save_books(books)
      hash_arr = []
      @books.each {|book| hash_arr << {publisher: book.publisher, cover_state: book.cover_state, publish_date: book.publish_date}}
      File.open('storage/books.json', 'w') {|s| s << hash_arr.to_json}
      puts 'saving books'
      puts hash_arr
    end
  
    def save_labels(labels)
      hash_arr = []
      @labels.each {|label| hash_arr << {title: label.title, color: label.color, items: label.items}}
      File.open('storage/labels.json', 'w') { |s| s << hash_arr.to_json }
      puts 'saving data'
      puts hash_arr
    end
    save_books(books)
    save_labels(labels)
  end
  
  def load(books, labels)
    def load_books(books)
      return unless File.exist?('storage/books.json') && File.size?('storage/books.json')
  
      storage = JSON.parse(File.read('storage/books.json'))
      storage.map do |book|
        @books.push(Book.new(book['publisher'], book['cover_state'], book['publish_date']))
      end
    end
  
    def load_labels(labels)
      return unless File.exist?('storage/labels.json') && File.size?('storage/labels.json')
      storage = JSON.parse(File.read('storage/labels.json'))
      puts 'loading data'
      puts storage
      storage.map do |label|
        @labels.push(Label.new(label['title'], label['color']))
      end
    end
    @labels.each do |label|
      label.items.each {|item| item.label = label}
    end
    load_books(books)
    load_labels(labels)
  end
end
