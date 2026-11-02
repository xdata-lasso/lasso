-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Movie A', 'Studio A', 'Director A', 100000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'USA', 10);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1, 1, 1, 100.0, 200.0, 'Type B', 1995);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (2, 1, 1, 150.0, 250.0, 'Type A', 1995);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (3, 1, 1, 200.0, 300.0, 'Type A', 1995);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (4, 1, 1, 300.0, 400.0, 'Type C', 1994);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (5, 1, 1, 400.0, 500.0, 'Type D', 1996);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM film_market_estimation WHERE (YEAR = 1995) ORDER BY TYPE, film_market_estimation.estimation_id NULLS LAST;

/*
Gold Result:
('Type A',)
('Type A',)
('Type B',)
*/

-- Prediction Query
SELECT TYPE FROM film_market_estimation WHERE YEAR = 1995;

/*
Prediction Result:
('Type B',)
('Type A',)
('Type A',)
*/