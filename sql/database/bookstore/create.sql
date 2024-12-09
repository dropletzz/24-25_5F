CREATE DATABASE IF NOT EXISTS bookstore;

USE bookstore;

-- wishlist?
-- gift card?

DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS books_orders;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(64) NOT NULL,
  surname VARCHAR(64) NOT NULL,
  country_code CHAR(3) NOT NULL
);

CREATE TABLE books (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64) NOT NULL,
  author_id INT REFERENCES authors(id),
  genre VARCHAR(32),
  price FLOAT NOT NULL,
  description LONGTEXT
);

CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(64) NOT NULL UNIQUE,
  name VARCHAR(64) NOT NULL,
  surname VARCHAR(64) NOT NULL
);

CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL REFERENCES users(id),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE books_orders (
  book_id INT NOT NULL REFERENCES books(id),
  order_id INT NOT NULL REFERENCES orders(id),
  quantity INT NOT NULL,
  price FLOAT NOT NULL,
  PRIMARY KEY (book_id, order_id)
);

CREATE TABLE reviews (
  user_id INT NOT NULL REFERENCES users(id),
  book_id INT NOT NULL REFERENCES books(id),
  rating TINYINT NOT NULL,
  description TEXT,
  PRIMARY KEY (book_id, user_id)
);
