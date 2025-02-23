CREATE DATABASE IF NOT EXISTS ecommerce;

USE ecommerce;

DROP TABLE IF EXISTS products_orders;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products_carts;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(64) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  name VARCHAR(64) NOT NULL,
  surname VARCHAR(64) NOT NULL
);

CREATE TABLE products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(128) NOT NULL,
  description TEXT,
  image_url VARCHAR(512),
  price FLOAT NOT NULL
);

CREATE TABLE carts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products_carts (
  product_id INT NOT NULL REFERENCES products(id),
  cart_id INT NOT NULL REFERENCES carts(id) ON DELETE CASCADE,
  quantity INT NOT NULL,
  PRIMARY KEY (product_id, cart_id)
);

CREATE TABLE orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products_orders (
  product_id INT NOT NULL REFERENCES products(id),
  order_id INT NOT NULL REFERENCES orders(id),
  quantity INT NOT NULL,
  price FLOAT NOT NULL,
  PRIMARY KEY (product_id, order_id)
);
-- ------------------ --
-- FINE STRUTTURA DB  --
-- ------------------ --

INSERT INTO users (email, name, surname) VALUES
("tasdhrease@mone.it", "three", "mone"),
("luaassciasno@spaghetti.it", "luciano", "spaghetti"),
("willsaiaam@sciecheralapera.it", "william", "sciecheralapera"),
("mario@causto.it", "mario", "causto"),
("Paris@asdTorto.it", "Paris", "Torto"),
("erminidsaasao@ottone.com", "Erminio", "Ottadsone"),
("tasdasasdasdasdhomas@turbato.com", "Thomas", "Tobbayo"),
("eddie@ocasanedas.it", "Marco", "Ocane"),
("andrei@aaastroadssadye.it", "Giancarlo", "Atroce"),
("allahakbaraass@lidadsbero.itasd", "abdul", "hamas"),
("massimo@bosssaettiasdasd.idast", "masadssimo", "bossetti"),
("igor@mitisda.it", "Igor", "miti"),
("afghani21121@yahoo.com", "cielo", "blu"),
("tizio@libero.it","tiziano", "tizi"),
("cadsiompi@aruba.it", "ciompi", "ciampi"),
("musasdso@lini.it", "asMusasso", "Lini"),
("andreasi@libero.it", "andrej", "vladovic"),
("denis@dslibero.it", "Denis", "Dosio"),
("tizio@ldsaibero.it", "caaspitan", "schettino"),
("paul@co.co", "pasaul", "coddo"),
("devis@ucarlo.it", "dsaevisas", "ucarlo"),
("paris@torto.it", "paris", "torto"),
("Totti@orrina.it", "Totti", "orrina")
;


INSERT INTO products (name, price) VALUES
("Shampoo antiforfora", 4.7),
("Sofficino Findus", 17),
("Kisander Bueno", 2.5),
("Falce", 23.4),
("Martello", 3.7),
("Cotton fioc", 2.3),
("Porta bruschetta", 41.7),
("Pelle di canguro", 300),
("Perla nera", 691.4),
("Bibbia", 9.99),
("Corano", 9.99),
("Cornice 40x70", 10.2),
("Shampoo aromatizzato alla fragola", 9.76),
("Spazzola per peli di cane", 13),
("Statuetta di Peter Pan", 6.7),
("Dhillon", 0.01),
("Spazzolone bagno", 10),
("Led Senza Dispersione", 30.5),
("Estintore", 45)
;

-- crea 20 ordini fatti da utenti scelti a caso
DROP PROCEDURE IF EXISTS CreateRandomOrders;
CREATE PROCEDURE CreateRandomOrders()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_user_id INT;

    WHILE i <= 20 DO
        -- Seleziona un ID utente casuale
        SELECT id INTO random_user_id
        FROM users
        ORDER BY RAND()
        LIMIT 1;

        -- Inserisce un ordine casuale
        INSERT INTO orders (user_id)
        VALUES (random_user_id);

        SET i = i + 1;
    END WHILE;
END;

-- Esegui la procedura
CALL CreateRandomOrders();


-- aggiungi casualmente 100 prodotti agli ordini
DROP PROCEDURE IF EXISTS CreateRandomProductsOrders;
CREATE PROCEDURE CreateRandomProductsOrders()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_product_id INT;
    DECLARE random_order_id INT;
    DECLARE random_quantity INT;

    WHILE i <= 100 DO
        -- Seleziona un ID prodotto casuale
        SELECT id INTO random_product_id
        FROM products
        ORDER BY RAND()
        LIMIT 1;

        -- Seleziona un ID ordine casuale
        SELECT id INTO random_order_id
        FROM orders
        ORDER BY RAND()
        LIMIT 1;

        -- Genera una quantità casuale tra 1 e 20
        SET random_quantity = FLOOR(1 + (20 * RAND()));

        -- Inserisce il prodotto nell'ordine
        INSERT IGNORE INTO products_orders (product_id, order_id, quantity, price)
        VALUES (random_product_id, random_order_id, random_quantity, 0);

        SET i = i + 1;
    END WHILE;
END;

-- Esegui la procedura
CALL CreateRandomProductsOrders();


-- assegna il prezzo ai prodotti negli ordini
UPDATE products_orders SET
	price = (SELECT price FROM products WHERE id = product_id)
;

-- modifica il prezzo negli ordini per un prodotto
UPDATE products_orders SET
	price = price * (1 + RAND() - 0.5)
WHERE product_id = (SELECT product_id FROM products_orders ORDER BY RAND() LIMIT 1);

-- prodotti mai ordinati
INSERT INTO products (name, price) VALUES
("Pelliccia di cammello", 4999.99),
("Cappello con elica", 14.2);

-- utenti che non hanno mai fatto ordini
INSERT INTO users (email, name, surname) VALUES
("donald@us.gov", "Donald", "Trap"),
("dario.amodei@anthropic.org", "Dario", "Amodei");


UPDATE users
SET created_at = FROM_UNIXTIME(RAND() * (1739227200 - 1713842800 + 1) + 1713842800);
UPDATE orders
SET created_at = FROM_UNIXTIME(RAND() * (1739227200 - 1713842800 + 1) + 1713842800);
