-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic boundary conditions for COUNT(*): studios with 1, 2, and 3 films.
-- Also tests ORDER BY studio (inserted out of alphabetical order) and JOIN mutations (not all films are in film_market_estimation).
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Film A', 'Zeta Studio', 'Dir X', 1000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'Film B', 'Zeta Studio', 'Dir Y', 2000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'Film C', 'Alpha Studio', 'Dir Z', 3000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (4, 'Film D', 'Alpha Studio', 'Dir W', 4000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (5, 'Film E', 'Beta Studio', 'Dir V', 5000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (6, 'Film F', 'Gamma Studio', 'Dir U', 6000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (7, 'Film G', 'Gamma Studio', 'Dir T', 7000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (8, 'Film H', 'Gamma Studio', 'Dir S', 8000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'USA', 50);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1, 1, 1, 100.0, 200.0, 'Type A', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (2, 1, 6, 100.0, 200.0, 'Type A', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (3, 1, 7, 100.0, 200.0, 'Type A', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT studio FROM (SELECT studio, COUNT(*) AS n FROM film GROUP BY studio) WHERE (n = 2) ORDER BY studio;

/*
Gold Result:
('Alpha Studio',)
('Zeta Studio',)
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Alpha Studio',)
('Gamma Studio',)
('Zeta Studio',)
*/