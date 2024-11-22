USE library;

INSERT INTO authors (name, surname, country_code) VALUES
("William","Shakespear","GBR"),
("Dante", "Alighieri", "ITA"),
("Pablo", "Neruda", "ARG"),
("Fabio", "Volo", "ITA"),
("Wislawa", "Szymborska", "POL")
("Fabio", "Fazio", "ITA");

INSERT INTO books SET
	title = "La divina commedia",
  genre = "commedia"
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "La divina commedia"),
  author_id = (SELECT id FROM authors WHERE surname = "Alighieri")
;

INSERT INTO books SET
	title = "Vita nova",
  genre = "autobiografico"
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Vita nova"),
  author_id = (SELECT id FROM authors WHERE surname = "Alighieri")
;

INSERT INTO books SET
	title = "La tempesta",
  genre = "opera teatrale"
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "La tempesta"),
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO books SET
	title = "Amleto",
  genre = "opera teatrale"
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Amleto"),
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO books SET
	title = "Tutti i poemi di Shakespear",
  genre = "poesia"
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Tutti i poemi di Shakespear"),
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

INSERT INTO books SET
	title = "La gioia di scrivere",
  genre = "poesia"
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "La gioia di scrivere"),
  author_id = (SELECT id FROM authors WHERE surname = "Szymborska")
;

INSERT INTO books SET
	title = "Cento sonetti d'amore",
  genre = "poesia"
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Cento sonetti d'amore"),
  author_id = (SELECT id FROM authors WHERE surname = "Neruda")
;

INSERT INTO books SET
	title = "Raccolta di poesie random",
  genre = "poesia"
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Raccolta di poesie random"),
  author_id = (SELECT id FROM authors WHERE surname = "Neruda")
;
INSERT INTO books_authors SET
	book_id = (SELECT id FROM books WHERE title = "Raccolta di poesie random"),
  author_id = (SELECT id FROM authors WHERE surname = "Shakespear")
;

