require_relative 'item'

class Label
  attr_accessor :title, :color, :items
  attr_reader :id

  def initialize(title, color)
    @id = 1
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items.push(item)
  end
end
