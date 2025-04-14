
DROP DATABASE IF EXISTS traffico;
CREATE DATABASE traffico;
USE traffico;

CREATE TABLE Nodo (
	id INT PRIMARY KEY AUTO_INCREMENT,
	toponimo VARCHAR(100) NOT NULL,
	latitudine DECIMAL(10, 8) NOT NULL,
	longitudine DECIMAL(11, 8) NOT NULL
);

CREATE TABLE Arco (
	id INT PRIMARY KEY AUTO_INCREMENT,
	toponimo VARCHAR(100) NOT NULL,
	lunghezza DECIMAL(10, 2) NOT NULL,
	id_nodo_partenza INT NOT NULL,
	id_nodo_arrivo INT NOT NULL,
	pavimentazione VARCHAR(50),
	larghezza DECIMAL(5, 2),
	doppio_senso BOOLEAN,
	numero_corsie INT,
	corsia_mezzi_pub BOOLEAN,
	capacita_max INT,
	pendenza DECIMAL(5, 2),
	FOREIGN KEY (id_nodo_partenza) REFERENCES Nodo(id),
	FOREIGN KEY (id_nodo_arrivo) REFERENCES Nodo(id)
);

CREATE TABLE StazioneDiMisurazione (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_arco INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
	tipo VARCHAR(50) NOT NULL,
	latitudine DECIMAL(10, 8) NOT NULL,
	longitudine DECIMAL(11, 8) NOT NULL,
	FOREIGN KEY (id_arco) REFERENCES Arco(id)
);

CREATE TABLE Inquinante (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	soglia_attenzione DECIMAL(10, 5),
	soglia_allarme DECIMAL(10, 5)
);

CREATE TABLE Misurazione (
	id_stazione INT NOT NULL,
	id_inquinante INT,
	value DECIMAL(10, 5) NOT NULL,
	data DATETIME NOT NULL,
	-- PRIMARY KEY (id_stazione, data, id_inquinante),
	FOREIGN KEY (id_inquinante) REFERENCES Inquinante(id),
	FOREIGN KEY (id_stazione) REFERENCES StazioneDiMisurazione(id)
);

CREATE TABLE Utente (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	cognome VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	hash_password VARCHAR(255) NOT NULL
);




INSERT INTO Nodo(toponimo, latitudine, longitudine) VALUES
("A", 12.3, 133.07),
("B", 12.3, 133.07),
("C", 25, 133.07),
("D", 26, 133.07),
("E", 12.3, 133.07),
("F", 12.3, 133.07),
("G", 12, 133.07),
("H", 12.3, 133.07),
("I", 30, 133.07);

INSERT INTO Arco(toponimo, lunghezza, id_nodo_partenza, id_nodo_arrivo) VALUES
("strada1", 37.77, (SELECT id FROM Nodo WHERE toponimo = "A"), (SELECT id FROM Nodo WHERE toponimo = "B")),
("strada2", 40, (SELECT id FROM Nodo WHERE toponimo = "B"), (SELECT id FROM Nodo WHERE toponimo = "C")),
("strada3", 204.23, (SELECT id FROM Nodo WHERE toponimo = "C"), (SELECT id FROM Nodo WHERE toponimo = "D")),
("strada4", 11.34, (SELECT id FROM Nodo WHERE toponimo = "D"), (SELECT id FROM Nodo WHERE toponimo = "E")),
("strada5", 4, (SELECT id FROM Nodo WHERE toponimo = "E"), (SELECT id FROM Nodo WHERE toponimo = "F")),
("strada21", 5.00, (SELECT id FROM Nodo WHERE toponimo = "G"), (SELECT id FROM Nodo WHERE toponimo = "H")),
("strada10", 58, (SELECT id FROM Nodo WHERE toponimo = "F"), (SELECT id FROM Nodo WHERE toponimo = "A")),
("strada323", 60.00, (SELECT id FROM Nodo WHERE toponimo = "I"), (SELECT id FROM Nodo WHERE toponimo = "C"));
UPDATE Arco SET capacita_max = 100;

INSERT INTO StazioneDiMisurazione(nome, tipo, id_arco, latitudine, longitudine) VALUES
("s1", "aria", (SELECT id FROM Arco WHERE toponimo = "strada1"), 12.31000000, 133.07100000),
("s2", "traffico", (SELECT id FROM Arco WHERE toponimo = "strada2"), 12.32000000, 133.07200000),
("s3", "aria", (SELECT id FROM Arco WHERE toponimo = "strada4"), 26.01000000, 133.07300000),
("s4", "traffico", (SELECT id FROM Arco WHERE toponimo = "strada4"), 26.02000000, 133.07400000),
("s5", "traffico", (SELECT id FROM Arco WHERE toponimo = "strada10"), 12.33000000, 133.07500000),
("s6", "aria", (SELECT id FROM Arco WHERE toponimo = "strada10"), 12.34000000, 133.07600000),
("s7", "traffico", (SELECT id FROM Arco WHERE toponimo = "strada323"), 30.01000000, 133.07700000);

INSERT INTO Inquinante (nome, soglia_attenzione, soglia_allarme)  VALUES
('Particolato PM10', 0.00000, 50.00000),
('Particolato PM2.5', 0.00000, 25.00000),
('Ozono (O3)', 0.00000, 120.00000),
('Diossido di Azoto (NO2)', 0.00000, 200.00000),
('Monossido di Carbonio (CO)', 0.00000, 10.00000),
('Diossido di Zolfo (SO2)', 0.00000, 125.00000),
('Benzene (C6H6)', 0.00000, 5.00000),
('Ammoniaca (NH3)', 0.00000, 100.00000),
('Idrogeno Solforato (H2S)', 0.00000, 5.00000),
('Piombo (Pb)', 0.00000, 0.50000);
UPDATE Inquinante SET soglia_attenzione = soglia_allarme * 0.75;

INSERT INTO Misurazione (id_stazione, id_inquinante, value, data) VALUES
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s1"), (SELECT id FROM Inquinante WHERE nome = "Particolato PM10"), 75.5, '2024-04-01 08:00:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s1"), (SELECT id FROM Inquinante WHERE nome = "Particolato PM2.5"), 15.2, '2024-04-01 08:00:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s2"), NULL, 150, '2024-04-01 08:15:00'), -- Esempio di misurazione traffico (id_inquinante può essere NULL o avere un valore specifico se si misura un inquinante legato al traffico)
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s3"), (SELECT id FROM Inquinante WHERE nome = "Ozono (O3)"), 90.1, '2024-04-01 08:30:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s3"), (SELECT id FROM Inquinante WHERE nome = "Diossido di Azoto (NO2)"), 180.5, '2024-04-01 08:30:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s4"), NULL, 210, '2024-04-01 08:45:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s5"), NULL, 95, '2024-04-01 09:00:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s6"), (SELECT id FROM Inquinante WHERE nome = "Monossido di Carbonio (CO)"), 37.3, '2024-04-01 09:15:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s7"), NULL, 180, '2024-04-01 09:30:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s1"), (SELECT id FROM Inquinante WHERE nome = "Particolato PM10"), 140.2, '2024-04-04 01:00:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s3"), (SELECT id FROM Inquinante WHERE nome = "Ozono (O3)"), 105.7, '2024-04-01 10:30:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s1"), (SELECT id FROM Inquinante WHERE nome = "Diossido di Azoto (NO2)"), 150.8, '2024-04-02 12:00:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s6"), (SELECT id FROM Inquinante WHERE nome = "Benzene (C6H6)"), 2.1, '2024-04-02 14:45:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s2"), NULL, 175, '2024-04-03 07:00:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s4"), NULL, 230, '2024-04-03 18:00:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s7"), NULL, 195, '2024-04-04 09:45:00'),
((SELECT id FROM StazioneDiMisurazione WHERE nome = "s3"), (SELECT id FROM Inquinante WHERE nome = "Particolato PM2.5"), 18.9, '2024-04-04 21:30:00');

INSERT INTO Utente(id, nome, cognome, email, hash_password) VALUES
(1, 'Marco', 'Rossi', 'marco.rossi@email.com', 'hash1'),
(2, 'Luca', 'Bianchi', 'luca.bianchi@email.com', 'hash2'),
(3, 'Giulia', 'Verdi', 'giulia.verdi@email.com', 'hash3'),
(4, 'Sara', 'Neri', 'sara.neri@email.com', 'hash4'),
(5, 'Anna', 'Gallo', 'anna.gallo@email.com', 'hash5'),
(6, 'Davide', 'Ferrari', 'davide.ferrari@email.com', 'hash6'),
(7, 'Elena', 'Conti', 'elena.conti@email.com', 'hash7'),
(8, 'Francesco', 'Greco', 'francesco.greco@email.com', 'hash8'),
(9, 'Chiara', 'Romano', 'chiara.romano@email.com', 'hash9'),
(10, 'Matteo', 'De Luca', 'matteo.deluca@email.com', 'hash10');
