require_relative '../classes/book'

describe Book do
  context 'Testing Book class' do
    it 'move_to_archive method leaves archived as false if less than 10 years and cover_state "good"' do
      book = Book.new('Norma', 'good', Date.new(2015, 7, 7))
      book.move_to_archive
      expect(book.archived).to eq false
    end
    it 'move_to_archive method changes archived to true if more than 10 years' do
      book = Book.new('Norma', 'good', Date.new(2008, 7, 7))
      book.move_to_archive
      expect(book.archived).to eq true
    end
    it 'move_to_archive method changes archived to true if cover_state is "bad"' do
      book = Book.new('Norma', 'bad', Date.new(2018, 7, 7))
      book.move_to_archive
      expect(book.archived).to eq true
    end
  end
end
