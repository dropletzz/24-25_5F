USE ecommerce;

DELETE FROM Products_Orders;
DELETE FROM Orders;
DELETE FROM Users;
DELETE FROM Products;

INSERT INTO Users (email, name, surname) VALUES
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
("tizio@libero.it","spagnola", "airbag"),
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


INSERT INTO Products (name, price) VALUES
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
FOR i IN 1..20 DO
	INSERT INTO Orders SET
  	user_id = (SELECT id FROM Users ORDER BY RAND() LIMIT 1);
END FOR;

-- aggiungi casualmente 100 prodotti agli ordini
FOR i IN 1..100 DO
	INSERT IGNORE INTO Products_Orders SET
  	product_id = (SELECT id FROM Products ORDER BY RAND() LIMIT 1),
    order_id = (SELECT id FROM Orders ORDER BY RAND() LIMIT 1),
    quantity = FLOOR( 1 + (20 * RAND()) ),
    price = 0; -- prezzo impostato dopo
END FOR;

-- assegna il prezzo ai prodotti negli ordini
UPDATE Products_Orders SET
	price = (SELECT price FROM Products WHERE id = product_id)
;

-- prodotti mai ordinati
INSERT INTO Products (name, price) VALUES
("Pelliccia di cammello", 4999.99),
("Cappello con elica", 14.2);

-- utenti che non hanno mai fatto ordini
INSERT INTO Users (email, name, surname) VALUES
("donald@us.gov", "Donald", "Trap"),
("dario.amodei@anthropic.org", "Dario", "Amodei");

