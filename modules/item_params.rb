module ItemParameters
  def genre_getter
    puts('Select genre from the list:')
    puts('0. Create a new genre')
    list_all_genre(list_of_genre)
    option = gets.chomp
    select_genre(list_of_genre, (option.to_i - 1))
  end

  def label_getter
    puts('Select label from the list:')
    puts('0. Create a new label')
    list_all_labels
    option = gets.chomp
    select_label(option.to_i - 1)
  end

  def author_getter; end
end
