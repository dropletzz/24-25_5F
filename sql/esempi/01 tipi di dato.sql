-- Per maggiori dettagli si rimanda alla documentazione ufficiale
-- https://mariadb.com/kb/en/data-types

CREATE TABLE tipi_di_dato (
  numero_intero INT,
  numero_con_virgola FLOAT,
  numero_con_virgola_doppia_precisione DOUBLE,
  testo_lunghezza_fissa CHAR(32),
  testo_lunghezza_variabile VARCHAR(32),
  testo_molto_lungo TEXT,
  data_e_ora_1 DATETIME,
  data_e_ora_2 TIMESTAMP,
  solo_data DATE,
  solo_ora TIME,
  identificatore_uuid UUID
);

