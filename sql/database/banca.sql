CREATE DATABASE IF NOT EXISTS banca;

USE banca;

CREATE TABLE conti (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_utente VARCHAR(64) NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL
);

INSERT INTO conti (nome_utente, saldo) VALUES
('Alice Verdi', 1500.50),
('Bob Gialli', 800.75),
('Carlo Blu', 2200.00),
('Brigitta Bianchi', 660.05),
('Maria Neri', 2200.00);
