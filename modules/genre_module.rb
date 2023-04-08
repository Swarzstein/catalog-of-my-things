# require_relative '../classes/genre'
require 'json'

module GenreModule

  # @all_genre = []

  def get_genre(list_of_genre = @genres)
    puts('Select genre from the list:')
    list_all_genre(list_of_genre)
    puts("0. Create a new genre")
    option = gets.chomp
    genre = select_genre(list_of_genre, (option.to_i-1))
    genre
  end

  def list_all_genre(list_of_genre = @genres)
    if list_of_genre.empty?
      puts 'No genre to display. You can add one.'
    else
      list_of_genre.each_with_index { |genre, i| puts(" | #{i+1}. Genre: #{genre.name} | ") }
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
    @all_genre.each do |genre|
      genre if genre.id == id
    end
  end
end
