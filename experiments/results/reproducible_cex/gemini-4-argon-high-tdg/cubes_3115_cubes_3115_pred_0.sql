-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Alpha', 'Studio C', 'Zack Snyder', 500000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'Beta', 'Studio A', 'Christopher Nolan', 100000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'Gamma', 'Studio B', 'Christopher Nolan', 900000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (4, 'Delta', 'Studio D', 'Alfonso Cuaron', 300000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (10, 'USA', 50);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (20, 'UK', 15);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (100, 10, 1, 1000.0, 2000.0, 'Domestic', 2015);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (101, 20, 1, 500.0, 1500.0, 'International', 2016);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (102, 10, 2, 3000.0, 4000.0, 'Domestic', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM film ORDER BY director, film.film_id NULLS LAST;

/*
Gold Result:
('Alfonso Cuaron',)
('Christopher Nolan',)
('Christopher Nolan',)
('Zack Snyder',)
*/

-- Prediction Query
SELECT DISTINCT Director FROM film;

/*
Prediction Result:
('Zack Snyder',)
('Christopher Nolan',)
('Alfonso Cuaron',)
*/