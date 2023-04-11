require_relative '../classes/game'

describe Game do
  context 'Testing Game class' do
    it 'move_to_archive method leaves archived as false if less than 10 years and last played <= 2 years' do
      game = Game.new(true, Date.new(2022, 2, 7), Date.new(2015, 7, 7))
      game.move_to_archive
      expect(game.archived).to eq false
    end
    it 'move_to_archive method changes archived to true if more than 10 years' do
      game = Game.new(true, Date.new(2022, 2, 7), Date.new(2005, 7, 7))
      game.move_to_archive
      expect(game.archived).to eq true
    end
    it 'move_to_archive method changes archived to true if last played > 2 years' do
      game = Game.new(true, Date.new(2019, 2, 7), Date.new(2015, 7, 7))
      game.move_to_archive
      expect(game.archived).to eq true
    end
  end
end
