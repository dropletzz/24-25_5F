

USE ecommerce;

-- creo un utente
INSERT INTO users (email, name, surname) VALUES
    email = "mario.braghe@gmail.it",
    name = "Mario",
    surname = "Braghe"
;

-- vorrei creare un ordine associato all'utente
-- ma non conosco il suo id:
-- posso ottenerlo tramite una sottoquery
INSERT INTO orders SET
    user_id = (SELECT id FROM users WHERE email = "mario.braghe@gmail.it")
;

-- L'operatore IN controlla che un valore sia
-- contenuto in una lista. Come nei seguenti esempi:

-- seleziona gli utenti con determinati id
SELECT * FROM users
WHERE id IN (5, 12, 23);
-- che e' equivalente a questa
SELECT * FROM users
WHERE id = 5 OR id = 12 OR id = 23;

-- La lista di valori passata a IN puo' anche essere
-- il risultato di una sottoquery, ad esempio:

-- seleziona gli utenti che hanno fatto almeno un post
SELECT * FROM users
WHERE id IN (SELECT user_id FROM posts);

-- seleziona gli utenti che hanno un
-- post che ha ricevuto almeno 3 like
SELECT * FROM users
WHERE id IN (
  SELECT posts.user_id
  FROM posts JOIN post_likes ON posts.id = post_likes.post_id
  GROUP BY posts.id
  HAVING COUNT(*) >= 3
);


USE customer_care;
-- seleziona gli operatori che parlano
-- sia italiano che francese
SELECT op_ita.* FROM (
  SELECT o.* FROM operatore o
  JOIN operatore_lingua ol ON ol.FK_ID_Operatore = o.ID_Operatore
  WHERE ol.FK_Codice_Lingua = "IT"
) op_ita
JOIN operatore_lingua ol ON op_ita.ID_Operatore = ol.FK_ID_Operatore
WHERE ol.FK_Codice_Lingua = "FR";

-- stessa query di prima ma con le CTE (più chiara)
WITH op_ita AS (
  SELECT o.* FROM operatore o
  JOIN operatore_lingua ol ON ol.FK_ID_Operatore = o.ID_Operatore
  WHERE ol.FK_Codice_Lingua = "IT"
)
SELECT op_ita.* FROM op_ita
JOIN operatore_lingua ol ON op_ita.ID_Operatore = ol.FK_ID_Operatore
WHERE ol.FK_Codice_Lingua = "FR";
