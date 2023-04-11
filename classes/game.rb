require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(multiplayer, last_played_at, publish_date)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  private

  def can_be_archived?
    old = Time.now.year - @publish_date.year
    last_played_at = Time.now.year - @last_played_at.year
    old > 10 || last_played_at > 2
  end
end
