# require_relative '../classes/label'

module LabelModule
  def list_all_labels
    if @labels.length >= 1
      @labels.each_with_index { |label, i| puts "#{i + 1} - Title: \"#{label.title}\", Color: \"#{label.color}\" " }
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

  def save_labels
    hash_arr = []
    @labels.each do |label|
      hash_arr << label_hash(label)
    end
    File.write('./data/labels.json', JSON.pretty_generate(hash_arr))
  end

  def load_labels
    return [] unless File.exist?('data/labels.json') && File.size?('data/labels.json')

    JSON.parse(File.read('data/labels.json'))
  end
end
