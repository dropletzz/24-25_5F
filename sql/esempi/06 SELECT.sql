USE library;

-- tutti i libri
SELECT * FROM books;

-- solo titolo e genere dei libri
SELECT title, genre FROM books;

-- titolo dei libri di un determinato genere
SELECT title
FROM books
WHERE genre = "horror";

-- tutti i generi (ripetuti se compaiono in piu' libri)
SELECT genre FROM books;

-- tutti i generi (senza ripetizioni)
SELECT DISTINCT genre FROM books;

-- tutti i generi (senza ripetizioni) con conteggio dei libri per ogni genere
SELECT genre, COUNT(*) AS conteggio_libri
FROM books
GROUP BY genre;

