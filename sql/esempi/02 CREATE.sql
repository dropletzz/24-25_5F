USE library;

-- crea un database chiamato library se non esiste gia
CREATE DATABASE IF NOT EXISTS library;

-- seleziona il db library
USE library;

-- elimina tabelle se esistono gia
DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

-- crea una tabella
CREATE TABLE books (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64) NOT NULL,
  genre VARCHAR(64),
  description LONGTEXT
);

CREATE TABLE authors (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- chiave primaria autoincementale
  name VARCHAR(64) NOT NULL,
  surname VARCHAR(64) NOT NULL,
  country_code CHAR(3) NOT NULL
);

CREATE TABLE books_authors (
  book_id INT NOT NULL REFERENCES books(id), -- chiave esterna
  author_id INT NOT NULL REFERENCES authors(id), -- chiave esterna
  PRIMARY KEY(book_id, author_id) -- chiave primaria composta
);

