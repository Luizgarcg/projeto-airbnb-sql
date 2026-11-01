-- Projeto Airbnb Rio de Janeiro: preparacao do banco (MySQL)
-- Rode este arquivo UMA vez, antes de consultas_airbnb.sql.
-- Troque os dois caminhos 'C:/COLE/O/SEU/CAMINHO/...' pelos caminhos dos seus arquivos
-- (use barras normais /, e nao a barra invertida \).

SET GLOBAL local_infile = 1;

CREATE DATABASE IF NOT EXISTS airbnb_projeto;
USE airbnb_projeto;

-- Tabela de anuncios (listings.csv do Inside Airbnb)
DROP TABLE IF EXISTS listings;
CREATE TABLE listings (
  id BIGINT,
  name TEXT,
  host_id BIGINT,
  host_profile_id VARCHAR(30),
  host_name VARCHAR(255),
  neighbourhood_group VARCHAR(100),
  neighbourhood VARCHAR(100),
  latitude DOUBLE,
  longitude DOUBLE,
  room_type VARCHAR(50),
  price DOUBLE,
  minimum_nights INT,
  number_of_reviews INT,
  last_review DATE,
  reviews_per_month DOUBLE,
  calculated_host_listings_count INT,
  availability_365 INT,
  number_of_reviews_ltm INT,
  license VARCHAR(255)
);

LOAD DATA LOCAL INFILE 'C:/COLE/O/SEU/CAMINHO/listings.csv'
INTO TABLE listings
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, name, host_id, host_profile_id, host_name, neighbourhood_group, neighbourhood,
 latitude, longitude, room_type, @price, @min_nights, @n_reviews,
 @last_review, @rpm, @host_count, @avail, @n_ltm, @license)
SET price = NULLIF(@price, ''),
    minimum_nights = NULLIF(@min_nights, ''),
    number_of_reviews = NULLIF(@n_reviews, ''),
    last_review = NULLIF(@last_review, ''),
    reviews_per_month = NULLIF(@rpm, ''),
    calculated_host_listings_count = NULLIF(@host_count, ''),
    availability_365 = NULLIF(@avail, ''),
    number_of_reviews_ltm = NULLIF(@n_ltm, ''),
    license = NULLIF(TRIM(TRAILING '\r' FROM @license), '');

-- Tabela de avaliacoes (reviews.csv do Inside Airbnb)
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  listing_id BIGINT,
  id BIGINT,
  date DATE,
  reviewer_id BIGINT,
  reviewer_name VARCHAR(255),
  comments LONGTEXT
);

LOAD DATA LOCAL INFILE 'C:/COLE/O/SEU/CAMINHO/reviews.csv'
INTO TABLE reviews
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(listing_id, id, @date, reviewer_id, reviewer_name, @comments)
SET date = NULLIF(@date, ''),
    comments = TRIM(TRAILING '\r' FROM @comments);

-- Conferencia: compare com o total de linhas dos arquivos (menos o cabecalho)
SELECT COUNT(*) AS total_listings FROM listings;
SELECT COUNT(*) AS total_reviews FROM reviews;
