CREATE DATABASE IF NOT EXISTS images_spa;
USE images_spa;

CREATE OR REPLACE TABLE images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    url VARCHAR(128) NOT NULL,
    rating INT NOT NULL,
    description TEXT
)
