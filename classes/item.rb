require 'date'
require_relative 'genre'

class Item
  attr_accessor :genre, :author, :label, :publish_date, :archived
  attr_reader :id

  def initialize(publish_date)
    @id = Random.rand(100_000)
    @genre = nil
    @author = nil
    @label = nil
    @publish_date = publish_date
    @archived = false
  end

  def add_genre(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end

  private

  def can_be_archived?
    old = Time.now.year - @publish_date.year
    old > 10
  end

  public

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end
end
