USE library;

-- inserire una riga
INSERT INTO authors SET
name = "William",
surname = "Shakespear",
country_code = "GBR";

-- inserire una riga
INSERT INTO authors (name, surname, country_code)
VALUES ("Dante", "Alighieri", "ITA");

-- inserire piu' righe alla volta
INSERT INTO authors (name, surname, country_code)
VALUES ("Pablo", "Neruda", "ARG"),
       ("Fabio", "Volo", "ITA"),
       ("Wislawa", "Szymborska", "POL");


USE ecommerce;

-- e' anche possibile riempire una tabella con il risultato di una SELECT
-- ad esempio: voglio creare una tabella di riepilogo con tutti gli
-- utenti ed il conteggio degli ordini che hanno fatto:
-- 1) creo la tabella
CREATE TABLE users_summary (
    user_id INT REFERENCES users(id),
    order_count INT
);
-- 2) la riempio con i risultati di una select
INSERT INTO users_summary (user_id, order_count)
SELECT users.id, COUNT(orders.id)
FROM users LEFT JOIN orders ON users.id = orders.user_id;

-- ciao
