USE library;

-- cancella tutto il contenuto della tabella
DELETE FROM books;

-- cancella una singola riga
DELETE FROM books
WHERE id = 4;

-- cancella tutti i libri di un determinato genere
DELETE FROM books
WHERE genre = "poesia";

-- cancella tutti i libri di un determinato autore
DELETE FROM books
WHERE id IN (
  SELECT  books.id FROM books, books_authors AS ba
  WHERE ba.book_id = books.id AND ba.author_id = 1
);

