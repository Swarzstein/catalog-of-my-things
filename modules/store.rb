require 'date'

module Store
  def save_data
    save_books
    save_person
    save_rentals
  end

  def save_books
    File.open('store/books.json', 'w') { |s| s << @books.to_json }
  end

  def save_person
    File.open('store/person.json', 'w') { |s| s << @persons.to_json }
  end

  def save_rentals
    File.open('store/rentals.json', 'w') { |s| s << @rentals.to_json }
  end

  def load_data
    load_books
    load_person
    load_rentals
  end

  def load_books
    return unless File.exist?('store/books.json') && File.size?('store/books.json')

    store = JSON.parse(File.read('store/books.json'))
    store.map { |book| @books.push(Book.new(book['title'], book['author'])) }
  end

  def load_person
    return unless File.exist?('store/person.json') && File.size?('store/person.json')

    store = JSON.parse(File.read('store/person.json'))
    store.map do |person|
      if person['class'] == 'Student'

        @persons.push(Student.new(person['age'], person['name'], person['id'],
                                  parent_permission: person['parent_permission']))
      else
        @persons.push(Teacher.new(person['age'], person['specialization'], person['name'], person['id'],
                                  parent_permission: person['parent_permission']))
      end
    end
  end

  def load_rentals
    return unless File.exist?('store/rentals.json') && File.size?('store/rentals.json')

    JSON.parse(File.read('store/rentals.json')).each do |rental|
      rental_book = @books.find { |book| book.title == rental['book']['title'] }
      rental_person = @persons.find { |person| person.id == rental['person']['id'] }
      @rentals.push(Rental.new(rental['date'], rental_book, rental_person))
    end
  end
end
