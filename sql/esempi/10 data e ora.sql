
-- https://mariadb.com/kb/en/date-time-functions/
	
CREATE DATABASE IF NOT EXISTS date_prova;
USE date_prova;

CREATE TABLE tipi (
  solo_data DATE, -- '2003-10-24'
  solo_ora TIME, -- '14:30:15'
  data_e_ora1 DATETIME, -- '2003-10-24 14:30:15'
  data_e_ora2 TIMESTAMP -- '2003-10-24 14:30:15'
  -- differenze tra DATETIME e TIMESTAMP:
  -- * come viene gestito il fuso orario
  -- * limiti: timestamp non va oltre l'anno 2038
);

CREATE TABLE eventi (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
  date DATETIME NOT NULL
);

INSERT INTO eventi (name, date) VALUES
	('Fiera della porchetta', '2022-11-30 23:59:59'),
  ('Festa della musica', '2024-11-23 23:59:59'),
  ('Concerto alla Scala', '2024-12-30 23:59:59')
;

-- funzioni per estrarre parti di una data:
SELECT 
	YEAR(date) AS anno,
  MONTH(date) AS mese,
  DAY(date) AS giorno,
  HOUR(date) AS giorno,
  MINUTE(date) AS minuti,
  SECOND(date) AS secondi
FROM eventi;


-- DATEDIFF(d1, d2) restituisce la differenza tra
-- d1 e d2 calcolata in giorni
SELECT name, DATEDIFF(NOW(), date) AS diff
FROM eventi;
