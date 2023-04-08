require 'date'
require 'json'

module Store
  def book_hash(book)
    {
      id: book.id,
      genre: book.genre&.id,
      author: book.author&.id,
      label: book.label&.id,
      publish_date: {
        year: book.publish_date.year,
        month: book.publish_date.month,
        day: book.publish_date.day
      },
      archived: book.archived,
      publisher: book.publisher,
      cover_state: book.cover_state
    }
  end

  def album_hash(album)
    {
      id: album.id,
      genre: album.genre.id,
      author: album.author.id,
      label: album.label.id,
      publish_date: {
        year: album.publish_date.year,
        month: album.publish_date.month,
        day: album.publish_date.day
      },
      on_spotify: album.on_spotify
    }
  end

  def label_hash(label)
    items = []
    label.items.each do |item|
      items << { id: item.id, class: item.class.name }
    end
    {
      id: label.id,
      title: label.title,
      color: label.color,
      items: items
    }
  end

  def genre_hash(genre)
    items = []
    genre.items.each do |item|
      items << { id: item.id, class: item.class.name }
    end
    {
      id: genre.id,
      name: genre.name,
      items: items
    }
  end

  def save
    save_books
    save_labels
    save_genre
  end

  def load
    load_books
    # load_genres
  end
end
