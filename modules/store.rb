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

  def game_hash(game)
    {
      id: game.id,
      genre: game.genre&.id,
      author: game.author&.id,
      label: game.label&.id,
      publish_date: {
        year: game.publish_date.year,
        month: game.publish_date.month,
        day: game.publish_date.day
      },
      archived: game.archived,
      multiplayer: game.multiplayer,
      last_played_at: {
        year: game.last_played_at.year,
        month: game.last_played_at.month,
        day: game.last_played_at.day
      }
    }
  end

  def album_hash(album)
    {
      id: album.id,
      genre: album.genre&.id,
      author: album.author&.id,
      label: album.label&.id,
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

  def author_hash(author)
    items = []
    author.items.each do |item|
      items << { id: item.id, class: item.class.name }
    end
    {
      id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
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
    save_music_album
    save_games
    save_authors
  end

  def load
    load_books
    load_music_albums
    load_games
  end
end
