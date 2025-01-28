
CREATE DATABASE IF NOT EXISTS todolist;

USE todolist;

DROP TABLE todo;
CREATE TABLE todo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(128) NOT NULL,
    description TEXT NOT NULL DEFAULT "",
    done BOOLEAN DEFAULT FALSE
);

INSERT INTO todo (title, done) VALUES
("comprare le arance", TRUE),
("pulire il bagno", FALSE);