-- LINK UTILI
-- https://mariadb.com/kb/en/joining-tables-with-join-clauses/
-- https://www.devart.com/dbforge/mysql/studio/mysql-joins.html

CREATE TABLE t1 ( a INT );
CREATE TABLE t2 ( b INT );
INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (2), (4);

-- INNER JOIN
-- seleziona solo le righe dove c'e' una corrispondenza tra le due tabelle
SELECT * FROM t1 INNER JOIN t2 ON t1.a = t2.b;
-- equivalente a
SELECT * FROM t1 JOIN t2 ON t1.a = t2.b;
-- risultato:
-- ------ ------ 
-- | a    | b    |
-- ------ ------ 
-- |    2 |    2 |
-- ------ ------ 

-- LEFT JOIN
-- seleziona tutte le righe delle prima tabella e aggiunge quelle
-- della seconda tabella se c'e' una corrispondenza
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.b;
-- risultato:
-- ------ ------
-- | a    | b    |
-- ------ ------
-- |    1 | NULL |
-- |    2 |    2 |
-- |    3 | NULL |
-- ------ ------

-- RIGHT JOIN
-- seleziona tutte le righe delle seconda tabella e aggiunge quelle
-- della prima tabella se c'e' una corrispondenza
SELECT * FROM t1 RIGHT JOIN t2 ON t1.a = t2.b;
-- risultato:
-- ------ ------
-- | a    | b    |
-- ------ ------
-- |    2 |    2 |
-- | NULL |    4 |
-- ------ ------

-- CROSS JOIN
-- seleziona tutte le possibili combinazioni tra le righe delle due tabelle
SELECT * FROM t1 CROSS JOIN t2;
-- risultato:
-- ------ ------ 
-- | a    | b    |
-- ------ ------ 
-- |    1 |    2 |
-- |    2 |    2 |
-- |    3 |    2 |
-- |    1 |    4 |
-- |    2 |    4 |
-- |    3 |    4 |
-- ------ ------ 


USE library;

-- tutti gli editori (publishers) ed i libri che hanno pubblicato
-- un editore che ha pubblicato piu' libri sara' ripetuto per ogni libro
-- gli editori che non hanno pubblicato libri non compaiono
SELECT p.name AS publisher, b.title AS book
FROM publishers p JOIN books b ON p.id = b.publisher_id;

-- tutti gli editori (publishers) ed i libri che hanno pubblicato
-- un editore che ha pubblicato piu' libri sara' ripetuto per ogni libro
-- compaiono anche gli editori che non hanno mai pubblicato libri
SELECT p.name AS publisher, b.title AS book
FROM publishers p LEFT JOIN books b ON p.id = b.publisher_id;

-- tutti gli editori (publishers) ed il conteggio di libri che hanno pubblicato
-- compaiono anche gli editori che non hanno mai pubblicato libri
SELECT p.name AS publisher, COUNT(b.id) AS book_count
FROM publishers p LEFT JOIN books b ON p.id = b.publisher_id
GROUP BY p.id;

-- tutti gli editori (publishers) che non hanno mai pubblicato libri
SELECT p.name AS publisher
FROM publishers p LEFT JOIN books b ON p.id = b.publisher_id
WHERE b.id IS NULL
GROUP BY p.id;

-----------------------------------------------------------------
-- Le query seguenti sono analoghe a quelle precedenti ma,
-- invece che la relazione tra editori e libri (1-N),
-- riguardano la relazione tra autori e libri (N-N)
-----------------------------------------------------------------

-- tutti gli autori ed i libri che hanno scritto
-- un autore che ha scritto piu' libri sara' ripetuto per ogni libro
-- gli autori che non hanno nessun libro non compaiono
SELECT a.name, a.surname, b.title
FROM authors a
JOIN books_authors ba ON a.id = ba.author_id
JOIN books b ON ba.book_id = b.id;

-- tutti gli autori ed i libri che hanno scritto
-- un autore che ha scritto piu' libri sara' ripetuto per ogni libro
-- compaiono anche gli autori che non hanno nessun libro
SELECT a.name, a.surname, b.title
FROM authors a
LEFT JOIN books_authors ba ON a.id = ba.author_id
LEFT JOIN books b ON ba.book_id = b.id;

-- tutti gli autori ed i conteggio di quanti libri hanno scritto
-- compaiono anche gli autori che non hanno nessun libro
SELECT a.name, a.surname, COUNT(b.id) AS book_count
FROM authors a
LEFT JOIN books_authors ba ON a.id = ba.author_id
LEFT JOIN books b ON ba.book_id = b.id
GROUP BY a.id;


-- tutti gli autori che non hanno mai pubblicato libri
SELECT a.name, a.surname
FROM authors a
LEFT JOIN books_authors ba ON a.id = ba.author_id
WHERE ba.book_id IS NULL
GROUP BY a.id;
