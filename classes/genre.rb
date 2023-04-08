class Genre
  attr_accessor :name, :id
  attr_reader :items

  def initialize(name)
    @id = Time.now.to_i
    @name = name
    @items = []
  end

  def add_item(item)
    item.genre = self
    @items << item
  end
end
