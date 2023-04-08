require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played

  def initialize(multiplayer, last_played, publish_date)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played = last_played
  end

  private

  def can_be_archived?
    old = Time.now.year - @publish_date.year
    last_played = Time.now.year - @last_played.year
    old > 10 || last_played > 2
  end
end
