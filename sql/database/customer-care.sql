CREATE DATABASE customer_care;
USE customer_care;

-- Tabella per le Lingue
CREATE TABLE LINGUA (
    Codice_Lingua CHAR(2) NOT NULL COMMENT 'es. IT, EN',
    Nome_Lingua VARCHAR(50) NOT NULL,
    PRIMARY KEY (Codice_Lingua),
    UNIQUE KEY UQ_Nome_Lingua (Nome_Lingua)
) COMMENT='Anagrafica delle lingue supportate';

-- Tabella per i Clienti
CREATE TABLE CLIENTE (
    ID_Cliente INT UNSIGNED NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Documento_Riconoscimento_Tipo VARCHAR(50) NULL COMMENT 'es. CI, Passaporto',
    Documento_Riconoscimento_Numero VARCHAR(50) NULL,
    Data_Registrazione TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ID_Cliente),
    UNIQUE KEY UQ_Email_Cliente (Email)
) COMMENT='Anagrafica dei clienti';

-- Tabella per gli Operatori del Customer Care
CREATE TABLE OPERATORE (
    ID_Operatore INT UNSIGNED NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    Capacita_Decisionale ENUM('L1', 'L2', 'L3') NOT NULL DEFAULT 'L1' COMMENT 'Livello di competenza e autonomia decisionale',
    PRIMARY KEY (ID_Operatore)
) COMMENT='Anagrafica degli operatori del Customer Care';

-- Tabella associativa per le competenze linguistiche degli Operatori
CREATE TABLE OPERATORE_LINGUA (
    FK_ID_Operatore INT UNSIGNED NOT NULL,
    FK_Codice_Lingua CHAR(2) NOT NULL,
    PRIMARY KEY (FK_ID_Operatore, FK_Codice_Lingua),
    CONSTRAINT FK_OperatoreLingua_Operatore FOREIGN KEY (FK_ID_Operatore) REFERENCES OPERATORE(ID_Operatore) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_OperatoreLingua_Lingua FOREIGN KEY (FK_Codice_Lingua) REFERENCES LINGUA(Codice_Lingua) ON DELETE RESTRICT ON UPDATE CASCADE
) COMMENT='Lingue parlate da ciascun operatore (almeno 2, incluso Inglese)';

-- Tabella per i Ticket di assistenza
CREATE TABLE TICKET (
    ID_Ticket INT UNSIGNED NOT NULL AUTO_INCREMENT,
    FK_ID_Cliente INT UNSIGNED NOT NULL,
    Reservation_Number VARCHAR(50) NULL COMMENT 'Numero di prenotazione',
    Flight_Number VARCHAR(20) NULL COMMENT 'Numero del volo',
    FK_Codice_Lingua_Richiesta CHAR(2) NOT NULL COMMENT 'Lingua richiesta dal cliente per l''assistenza',
    Oggetto_Richiesta VARCHAR(255) NULL,
    Data_Ora_Inoltro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e ora di apertura del ticket',
    Livello_Attuale ENUM('L1', 'L2', 'L3') NOT NULL DEFAULT 'L1' COMMENT 'Livello di complessita attuale del ticket',
    Stato_Ticket ENUM('Aperto', 'Chiuso_Risolto', 'Chiuso_Irricevibile') NOT NULL DEFAULT 'Aperto' COMMENT 'Stato attuale del ticket',
    PRIMARY KEY (ID_Ticket),
    CONSTRAINT FK_Ticket_Cliente FOREIGN KEY (FK_ID_Cliente) REFERENCES CLIENTE(ID_Cliente) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT FK_Ticket_LinguaRichiesta FOREIGN KEY (FK_Codice_Lingua_Richiesta) REFERENCES LINGUA(Codice_Lingua) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX IDX_Reservation_Number (Reservation_Number),
    INDEX IDX_Flight_Number (Flight_Number)
) COMMENT='Richieste di assistenza dei clienti';

-- Tabella per i Feedback dei Clienti sui Ticket
CREATE TABLE FEEDBACK_CLIENTE (
    ID_Feedback INT UNSIGNED NOT NULL AUTO_INCREMENT,
    FK_ID_Ticket INT UNSIGNED NOT NULL,
    Valutazione_Soddisfazione ENUM('Ottimo', 'Buono', 'Sufficiente', 'Insufficiente', 'Pessimo') NOT NULL,
    Motivazioni TEXT NULL,
    Data_Feedback TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ID_Feedback),
    UNIQUE KEY UQ_Feedback_Ticket (FK_ID_Ticket) COMMENT 'Un solo feedback per ticket',
    CONSTRAINT FK_Feedback_Ticket FOREIGN KEY (FK_ID_Ticket) REFERENCES TICKET(ID_Ticket) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT='Feedback dei clienti sull''assistenza ricevuta per un ticket';

-- Tabella per i Giudizi Interni degli Operatori sul comportamento dei Clienti
CREATE TABLE GIUDIZIO_INTERNO_CLIENTE (
    ID_Giudizio INT UNSIGNED NOT NULL AUTO_INCREMENT,
    FK_ID_Ticket INT UNSIGNED NOT NULL COMMENT 'Ticket a cui si riferisce il giudizio',
    FK_ID_Operatore_Esprimente INT UNSIGNED NOT NULL COMMENT 'Operatore che ha espresso il giudizio',
    Descrizione_Comportamento_Cliente TEXT NOT NULL COMMENT 'Descrizione del comportamento del cliente',
    Data_Giudizio TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (ID_Giudizio),
    CONSTRAINT FK_Giudizio_Ticket FOREIGN KEY (FK_ID_Ticket) REFERENCES TICKET(ID_Ticket) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Giudizio_Operatore FOREIGN KEY (FK_ID_Operatore_Esprimente) REFERENCES OPERATORE(ID_Operatore) ON DELETE RESTRICT ON UPDATE CASCADE
) COMMENT='Giudizi interni degli operatori sul cliente (per segnalare soggetti difficili)';

-- Tabella per gli Eventi/Iterazioni legati a un Ticket
CREATE TABLE EVENTO (
    ID_Evento INT UNSIGNED NOT NULL AUTO_INCREMENT,
    FK_ID_Ticket INT UNSIGNED NOT NULL,
    FK_ID_Operatore INT UNSIGNED NULL COMMENT 'Operatore che ha gestito l''evento (NULL se azione di sistema)',
    Tipo_Evento ENUM('CREAZIONE', 'ASSEGNAZIONE', 'TELEFONATA', 'EMAIL', 'CAMBIO_LIVELLO', 'NOTA_OPERATORE', 'CHIUSURA') NOT NULL COMMENT 'Tipologia di evento registrato',
    Data_Ora_Evento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e ora in cui l''evento e stato registrato',
    Data_Ora_Inizio_Intervento TIMESTAMP NULL COMMENT 'Per interventi specifici dell''operatore',
    Data_Ora_Fine_Intervento TIMESTAMP NULL COMMENT 'Per interventi specifici dell''operatore',
    Codice_Attivita_Svolta VARCHAR(50) NULL COMMENT 'Codice dell''attivita svolta dall''operatore',
    Nota_Esplicativa TEXT NULL,
    Esito_Intervento ENUM('RISOLTO_POSITIVAMENTE', 'RICHIESTA_IRRICEVIBILE', 'OPERATORE_NON_ABILITATO') NULL COMMENT 'Esito dell''intervento specifico dell''operatore',
    Dati_Aggiuntivi_Evento JSON NULL COMMENT 'Dati specifici per tipo di evento (es. percorso del file audio, contenuto email)',
    PRIMARY KEY (ID_Evento),
    CONSTRAINT FK_Evento_Ticket FOREIGN KEY (FK_ID_Ticket) REFERENCES TICKET(ID_Ticket) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Evento_Operatore FOREIGN KEY (FK_ID_Operatore) REFERENCES OPERATORE(ID_Operatore) ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT='Tracciamento di tutte le comunicazioni e interventi su un ticket';
