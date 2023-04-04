require 'date'

class Item
  attr_accessor :genre, :author, :lable, :publish_date, :archived
  def initialize(publish_date)
    @id = Random.new(100000)
    @genre = nil
    @author = nil
    @lable = nil
    @publish_date = publish_date
    @archived = false
  end

  private

  def can_be_archived?
    old > 10
  end

  public

  def move_to_archive
    if can_be_archived?
      @archived = true
    end
  end
end