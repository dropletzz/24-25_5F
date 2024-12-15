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
-- ------------------ --
-- FINE STRUTTURA DB  --
-- ------------------ --


INSERT INTO authors (name, surname, country_code) VALUES
("William","Shakespear","GBR"),
("Dante", "Alighieri", "ITA"),
("Pablo", "Neruda", "ARG"),
("Fabio", "Volo", "ITA"),
("Wislawa", "Szymborska", "POL"),
("Fabio", "Fazio", "ITA")
;

INSERT INTO books SET
	title = "La divina commedia",
  genre = "commedia",
  price = 23.0,
  author_id = (SELECT id FROM authors WHERE surname = "Alighieri")
;
INSERT INTO books SET
	title = "Vita nova",
  genre = "autobiografico",
  price = 13.50,
  author_id = (SELECT id FROM authors WHERE surname = "Alighieri")
;

INSERT INTO books SET
	title = "La tempesta",
  genre = "opera teatrale",
  price = 16.0,
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO books SET
	title = "Amleto",
  genre = "opera teatrale",
  price = 32.0,
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO books SET
	title = "Tutti i poemi di Shakespear",
  genre = "poesia",
  price = 39.99,
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO books SET
	title = "La gioia di scrivere",
  genre = "poesia",
  price = 29.99,
  author_id = (SELECT id FROM authors WHERE surname = "Szymborska")
;

INSERT INTO books SET
	title = "Cento sonetti d'amore",
  genre = "poesia",
  price = 15.0,
  author_id = (SELECT id FROM authors WHERE surname = "Neruda")
;

INSERT INTO books SET
	title = "Raccolta di poesie random",
  genre = "poesia",
  price = 22.0,
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO users (email, name, surname) VALUES
("mario@aruba.com", "mario", "causto"),
("pari@gmail.com", "Pari", "Orbo"),
("erminidsaasao@ottone.com", "Erminio", "Ottadsone"),
("tasdasasdasdasdhomas@turbato.com", "Thomas", "Tobbayo"),
("eddie@libero.it", "Marco", "Cane"),
("andrei@sharklasers.com", "Giancarlo", "Atroce"),
("allahakbaraass@libero.ir", "abdul", "hamas"),
("massimo@aruba.com", "masadssimo", "bossetti"),
("cieloblu@yahoo.com", "cielo", "blu"),
("tizio@sharklasers.com","tiziano", "tizi"),
("cadsiompi@aruba.it", "ciompi", "ciampi"),
("andreasi@libero.it", "andrej", "vladovic"),
("devis@ucarlo.it", "dsaevisas", "ucarlo"),
("Totti@orrina.it", "Totti", "orrina")
;

DROP PROCEDURE IF EXISTS RandomOrders;
CREATE PROCEDURE RandomOrders()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 20 DO
			INSERT IGNORE INTO orders SET
        user_id = (SELECT id FROM users ORDER BY RAND() LIMIT 1);
      SET i = i + 1;
    END WHILE;
END;
CALL RandomOrders();

DROP PROCEDURE IF EXISTS RandomProductsOrders;
CREATE PROCEDURE RandomProductsOrders()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 55 DO
			INSERT IGNORE INTO books_orders SET
        book_id = (SELECT id FROM books ORDER BY RAND() LIMIT 1),
        order_id = (SELECT id FROM orders ORDER BY RAND() LIMIT 1),
        quantity = FLOOR(1 + (5 * RAND())),
        price = 0; -- prezzo impostato dopo
      SET i = i + 1;
    END WHILE;
END;
CALL RandomProductsOrders();

-- tutti gli ordini sono di un mese fa
UPDATE orders SET created_at = NOW() - INTERVAL 31 DAY;

-- tranne questi
INSERT INTO orders SET
user_id = (SELECT id FROM users WHERE email = "cieloblu@yahoo.com");

INSERT INTO books_orders SET
order_id = (SELECT o.id FROM orders o JOIN users u ON o.user_id = u.id WHERE email = "cieloblu@yahoo.com" ORDER BY created_at DESC LIMIT 1),
book_id = (SELECT id FROM books WHERE title = "La divina commedia"),
quantity = 6,
price = 0;
	

INSERT INTO orders SET
user_id = (SELECT id FROM users WHERE email = "eddie@libero.it");

INSERT INTO books_orders SET
order_id = (SELECT o.id FROM orders o JOIN users u ON o.user_id = u.id WHERE email = "cieloblu@yahoo.com" ORDER BY created_at DESC LIMIT 1),
book_id = (SELECT id FROM books WHERE title = "Cento sonetti d'amore"),
quantity = 1,
price = 0;

INSERT INTO books_orders SET
order_id = (SELECT o.id FROM orders o JOIN users u ON o.user_id = u.id WHERE email = "cieloblu@yahoo.com" ORDER BY created_at DESC LIMIT 1),
book_id = (SELECT id FROM books WHERE title = "Raccolta di poesie random"),
quantity = 1,
price = 0;

-- imposta i prezzi i books_orders
UPDATE books_orders SET
  price = (SELECT price FROM books WHERE id = book_id)
;


-- utenti che non hanno mai ordinato niente
INSERT INTO users (email, name, surname) VALUES
("denis@sharklasers.com", "Denis", "Dosio"),
("tizio@libero.it", "Caspian", "schettino"),
("paul@co.co", "pasaul", "coddo")
;

-- libro mai ordinato
INSERT INTO books SET
	title = "Una gran voglia di vivere",
  genre = "motivazionale",
  price = 9.99,
  author_id = (SELECT id FROM authors WHERE surname = "Volo")
;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- recensioni

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "La divina commedia"),
  user_id = (SELECT id FROM users WHERE email = "eddie@libero.it"),
  rating = 5,
  description = "Sopravvalutata"
;


INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "La divina commedia"),
  user_id = (SELECT id FROM users WHERE email = "cadsiompi@aruba.it"),
  rating = 8
;

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "Vita Nova"),
  user_id = (SELECT id FROM users WHERE email = "cadsiompi@aruba.it"),
  rating = 9
;

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "Vita Nova"),
  user_id = (SELECT id FROM users WHERE email = "devis@ucarlo.it"),
  rating = 9
;

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "Amleto"),
  user_id = (SELECT id FROM users WHERE email = "devis@ucarlo.it"),
  rating = 6
;

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "Amleto"),
  user_id = (SELECT id FROM users WHERE email = "cieloblu@yahoo.com"),
  rating = 7
;

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "Amleto"),
  user_id = (SELECT id FROM users WHERE email = "pari@gmail.com"),
  rating = 8
;

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "La gioia di scrivere"),
  user_id = (SELECT id FROM users WHERE email = "cieloblu@yahoo.com"),
  rating = 10
;

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "La gioia di scrivere"),
  user_id = (SELECT id FROM users WHERE email = "cadsiompi@aruba.it"),
  rating = 9
;

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "La gioia di scrivere"),
  user_id = (SELECT id FROM users WHERE email = "massimo@aruba.com"),
  rating = 9
;

insert into reviews set
  book_id = (select id from books where title = "una gran voglia di vivere"),
  user_id = (select id from users where email = "massimo@aruba.com"),
  description = "na roba oribbile",
  rating = 0
;
insert into reviews set
  book_id = (select id from books where title = "una gran voglia di vivere"),
  user_id = (select id from users where email = "pari@gmail.com"),
  description = "mi ha cambiato la vita",
  rating = 10
;


-- recensioni fatte dai bot

INSERT INTO reviews SET
  book_id = (SELECT id FROM books WHERE title = "La gioia di scrivere"),
  user_id = (select id from users where email = "andrei@sharklasers.com"),
  description = "bot boobototo",
  rating = 7
;

INSERT INTO reviews SET
  book_id = (select id from books where title = "una gran voglia di vivere"),
  user_id = (select id from users where email = "tizio@sharklasers.com"),
  description = "boto obovo",
  rating = 10
;
