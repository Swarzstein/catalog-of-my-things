require_relative '../classes/label'

class Item
  attr_accessor :genre, :author, :lable, :publish_date, :archived

  def initialize(publish_date)
    @id = Random.new(100_000)
    @genre = nil
    @author = nil
    @lable = nil
    @publish_date = publish_date
    @archived = false
  end
end

describe Label do
  context 'Testing Lable class' do
    it 'add_item adds an item' do
      label = Label.new('New', 'White')
      label.add_item(Item.new(Date.new(2015, 7, 7)))
      expect(label.items.length).to eq 1
      expect(label.items[0].publish_date.year).to eq 2015
    end
  end
end
