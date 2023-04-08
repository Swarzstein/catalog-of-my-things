# require_relative '../classes/label'

module LabelModule
  def list_all_labels
    if @labels.length >= 1
      @labels.each_with_index { |label, i| puts "#{i + 1} - Title: \"#{label.title}\", Color: \"#{label.color}\" "}
    else
      puts "There's no label registered"
    end
  end

  def select_label(index)
    if index < @labels.length && index >= 0
      @labels[index]
    elsif index == -1
      print('New label title: ')
      title = gets.chomp
      print('New label color: ')
      color = gets.chomp
      label = Label.new(title, color)
      @labels.push(label)
      label
    end
  end

  def get_label
    puts('Select label from the list:')
    puts("0. Create a new label")
    list_all_labels
    option = gets.chomp
    label = select_label(option.to_i - 1)
    label
  end
end