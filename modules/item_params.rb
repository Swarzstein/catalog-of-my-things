module ItemParameters
  def list_all_labels
    if @labels.length >= 1
      @labels.each_with_index {|label, i| puts "#{i + 1} - Title: \"#{label.title}\", Color: \"#{label.color}\" "} 
    else
      puts "There's no label registered"
    end
  end
  

  def get_genre
    puts('Select genre from the list:')
    list_all_genre(list_of_genre)
    puts("0. Create a new genre")
    option = gets.chomp
    genre = select_genre(list_of_genre, (option.to_i-1))
    genre
  end

  def get_label

  end

  def get_author

  end
end