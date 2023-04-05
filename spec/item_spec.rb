require 'date'
require_relative '../classes/item'

describe Item do
  context 'When testing the Item class' do
    it 'move_to_archive method leaves archived as false if less than 10 years' do
      item = Item.new(Date.new(2015, 7, 7))
      item.move_to_archive
      expect(item.archived).to eq false
    end
    it 'move_to_archive method changes archived to true if has 10 years or more' do
      item = Item.new(Date.new(2008, 7, 7))
      item.move_to_archive
      expect(item.archived).to eq true
    end
  end
end
