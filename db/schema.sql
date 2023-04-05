CREATE DATABASE catalog;
\c catalog

CREATE TABLE book (
    id SERIAL PRIMARY KEY NOT NULL,
    publish_date DATE NOT NULL,
    archived BOOLEAN,
    publisher VARCHAR (200),
    cover_state VARCHAR (20),
    genre_id INTEGER,
    author_id INTEGER,
    label_id INTEGER
);

CREATE TABLE label (
    id SERIAL PRIMARY KEY NOT NULL,
    title VARCHAR (200),
    color VARCHAR (200)
);

ALTER TABLE book ADD CONSTRAINT fk_label FOREIGN KEY(label_id) REFERENCES label(id);
