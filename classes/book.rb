require_relative 'item'

class Book < Item
  def initialize(publisher, cover_state, publish_date)
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state
  end

  private

  def can_be_archived?
    old = Time.now.year - @publish_date.year
    old > 10 || @cover_state == 'bad'
  end
end
