-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (101, 'Inception', 'Warner Bros.', 'Christopher Nolan', 836800000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (102, 'Parasite', 'CJ Entertainment', 'Bong Joon-ho', 263000000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (103, 'Amelie', 'UGC', 'Jean-Pierre Jeunet', 174200000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (10, 'USA', 50);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (20, 'France', 15);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (30, 'Germany', 20);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (40, 'Brazil', 12);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1001, 10, 101, 50000.0, 90000.0, 'Theatrical', 2010);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1002, 20, 103, 10000.0, 25000.0, 'Broadcast', 2001);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1003, 10, 102, 30000.0, 60000.0, 'Streaming', 2005);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1004, 20, 101, 15000.0, 30000.0, 'Theatrical', 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country, YEAR FROM (SELECT LHS.market_id AS market_id, LHS.country AS country, LHS.number_cities AS number_cities, RHS.estimation_id AS estimation_id, RHS.low_estimate AS low_estimate, RHS.high_estimate AS high_estimate, RHS.film_id AS film_id, RHS.type AS TYPE, RHS.year AS YEAR FROM market AS LHS INNER JOIN film_market_estimation AS RHS ON (LHS.market_id = RHS.market_id)) ORDER BY country, YEAR NULLS LAST;

/*
Gold Result:
('France', 2001)
('France', 2019)
('USA', 2005)
('USA', 2010)
*/

-- Prediction Query
SELECT T2.Country, T1.Year FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID = T2.Market_ID;

/*
Prediction Result:
('USA', 2010)
('France', 2001)
('USA', 2005)
('France', 2019)
*/