require 'date'
require_relative '../classes/item'

describe Item do
  context 'When testing the Item class' do
    item1 = Item.new(Date(2015, 7, 7))
    item2 = Item.new(Date(2008, 7, 7))
    it "can be achieved? is false if less than 10 years published" do
      expect(item1.can_be_archived?).to eq false
    end
    it "can be achieved? is true if more than 10 years published" do
      expect(item.can_be_archived?).to eq true
    end
    it "move_to_archive method changes archived to true if more than 10 years" do
      item2.move_to_archive
      expect(item2.archived).to eq true
    end
  end
end
