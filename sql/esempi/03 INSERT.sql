USE library;

-- inserire una riga
INSERT INTO authors SET
name = "William",
surname = "Shakespear",
country_code = "GBR";

-- inserire una riga
INSERT INTO authors (name, surname, country_code)
VALUES ("Dante", "Alighieri", "ITA");

-- inserire piu righe alla volta
INSERT INTO authors (name, surname, country_code)
VALUES ("Pablo", "Neruda", "ARG"),
       ("Fabio", "Volo", "ITA"),
       ("Wislawa", "Szymborska", "POL");

