

USE ecommerce;

-- creo un utente
INSERT INTO users (email, name, surname) VALUES
    email = "mario.braghe@gmail.it",
    name = "Mario",
    surname = "Braghe"
;

-- per creare un ordine associato all'utente appena creato mi serve il suo id
-- posso ottenerlo tramite una sottoquery
INSERT INTO orders SET
    user_id = (SELECT id FROM users WHERE email = "mario.braghe@gmail.it")
;

-- e' anche possibile riempire una tabella con il risultato di una SELECT
-- ad esempio: se voglio creare una tabella di riepilogo con tutti gli
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
