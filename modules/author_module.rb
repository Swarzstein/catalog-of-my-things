module AuthorModule
  def list_all_authors
    if @authors.length >= 1
      @authors.each_with_index do |author, i|
        puts "#{i + 1} - First-Name: \"#{author.first_name}\", Last-Name: \"#{author.last_name}\" "
      end
    else
      puts "There's no author registered"
    end
  end

  def select_author(index)
    if index < @authors.length && index >= 0
      @authors[index]
    elsif index == -1
      print('First-Name: ')
      first_name = gets.chomp
      print('Last-Name: ')
      last_name = gets.chomp
      author = Author.new(first_name, last_name)
      @authors.push(author)
      author
    end
  end

  def author_getter
    puts('Select author from the list:')
    puts('0. Create a new author')
    list_all_authors
    option = gets.chomp
    select_author(option.to_i - 1)
  end

  def save_authors
    hash_arr = []
    @authors.each do |author|
      hash_arr << author_hash(author)
    end
    File.write('./data/authors.json', JSON.pretty_generate(hash_arr))
  end

  def load_authors
    return [] unless File.exist?('data/authors.json') && File.size?('data/authors.json')

    JSON.parse(File.read('data/authors.json'))
  end
end
