CREATE DATABASE IF NOT EXISTS library;

USE library;

DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS publishers;

CREATE TABLE publishers (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(64) NOT NULL
);

CREATE TABLE books (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  publisher_id INT REFERENCES publishers(id),
  title VARCHAR(64) NOT NULL,
  genre VARCHAR(64),
  description LONGTEXT
);

CREATE TABLE authors (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(64) NOT NULL,
  surname VARCHAR(64) NOT NULL,
  country_code CHAR(3) NOT NULL
);

CREATE TABLE books_authors (
  book_id INT NOT NULL REFERENCES books(id) ON DELETE CASCADE,
  author_id INT NOT NULL REFERENCES authors(id) ON DELETE CASCADE,
  PRIMARY KEY(book_id, author_id)
);
-- ------------------ --
-- FINE STRUTTURA DB  --
-- ------------------ --


INSERT INTO publishers (name) VALUES
("Penguin"),
("DeAgostini"),
("NERO Editions"),
("Edizioni Boh");

INSERT INTO authors (name, surname, country_code) VALUES
("William","Shakespear","GBR"),
("Dante", "Alighieri", "ITA"),
("Pablo", "Neruda", "ARG"),
("Fabio", "Volo", "ITA"),
("Wislawa", "Szymborska", "POL"),
("Fabio", "Fazio", "ITA");

INSERT INTO books SET
	title = "La divina commedia",
  genre = "commedia",
  publisher_id = (SELECT id FROM publishers WHERE name = "DeAgostini")
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "La divina commedia"),
  author_id = (SELECT id FROM authors WHERE surname = "Alighieri")
;

INSERT INTO books SET
	title = "Vita nova",
  genre = "autobiografico",
  publisher_id = (SELECT id FROM publishers WHERE name = "DeAgostini")
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Vita nova"),
  author_id = (SELECT id FROM authors WHERE surname = "Alighieri")
;

INSERT INTO books SET
	title = "La tempesta",
  genre = "opera teatrale",
  publisher_id = (SELECT id FROM publishers WHERE name = "Penguin")
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "La tempesta"),
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO books SET
	title = "Amleto",
  genre = "opera teatrale",
  publisher_id = (SELECT id FROM publishers WHERE name = "Penguin")
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Amleto"),
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO books SET
	title = "Tutti i poemi di Shakespear",
  genre = "poesia",
  publisher_id = (SELECT id FROM publishers WHERE name = "Penguin")
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Tutti i poemi di Shakespear"),
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO books SET
	title = "La gioia di scrivere",
  genre = "poesia",
  publisher_id = (SELECT id FROM publishers WHERE name = "Edizioni Boh")
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "La gioia di scrivere"),
  author_id = (SELECT id FROM authors WHERE surname = "Szymborska")
;

INSERT INTO books SET
	title = "Cento sonetti d'amore",
  genre = "poesia",
  publisher_id = (SELECT id FROM publishers WHERE name = "Edizioni Boh")
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Cento sonetti d'amore"),
  author_id = (SELECT id FROM authors WHERE surname = "Neruda")
;

INSERT INTO books SET
	title = "Raccolta di poesie random",
  genre = "poesia",
  publisher_id = NULL
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Raccolta di poesie random"),
  author_id = (SELECT id FROM authors WHERE surname = "Neruda")
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Raccolta di poesie random"),
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

