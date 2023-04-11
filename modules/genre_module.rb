module GenreModule
  def genre_getter(list_of_genre = @genres)
    puts('Select genre from the list:')
    list_all_genre(list_of_genre)
    puts('0. Create a new genre')
    option = gets.chomp
    select_genre(list_of_genre, (option.to_i - 1))
  end

  def list_all_genre(list_of_genre = @genres)
    if list_of_genre.empty?
      puts 'No genre to display. You can add one.'
    else
      list_of_genre.each_with_index { |genre, i| puts(" | #{i + 1}. Genre: #{genre.name} | ") }
    end
  end

  def select_genre(list_of_genre, index)
    if index < list_of_genre.length && index >= 0
      list_of_genre[index]
    elsif index == -1
      print('Enter the name of the genre: ')
      name = gets.chomp
      genre = Genre.new(name)
      @genres.push(genre) unless @genres.include?(genre)
      genre
    end
  end

  def return_genre(id)
    @genres.each do |genre|
      genre if genre.id == id
    end
  end

  def save_genre
    genre_list = []
    @genres.each do |genre|
      genre_list << genre_hash(genre)
    end
    File.write('data/genre.json', JSON.pretty_generate(genre_list))
  end

  def load_genres
    return unless File.exist?('data/genre.json') && File.size?('data/genre.json')

    JSON.parse(File.read('data/genre.json'))
  end
end
