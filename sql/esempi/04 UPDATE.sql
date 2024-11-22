USE library;

-- aggiorna una singola riga
UPDATE books SET
genre = "horror"
WHERE id = 4;

-- aggiorna tutti i libri di un determinato genere
UPDATE books SET
genre = "poesia"
WHERE genre = "poetica";

-- aggiornare tutti i libri di un determinato autore
UPDATE books SET
genre = "horror"
WHERE id IN (
  SELECT  books.id FROM books, books_authors AS ba
  WHERE ba.book_id = books.id AND ba.author_id = 1
);

