-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'F1', 'S1', 'D1', 100);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'F2', 'S2', 'D2', 200);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'F3', 'S3', 'D3', 300);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'M1', 10);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (2, 'M2', 20);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (3, 'M3', 30);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (30, 1, 3, 500.0, 900.0, 'B_Type', 1995);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (10, 3, 1, 900.0, 100.0, 'C_Type', 1995);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (20, 2, 2, 100.0, 500.0, 'A_Type', 1995);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM film_market_estimation WHERE (YEAR = 1995) ORDER BY TYPE, film_market_estimation.estimation_id NULLS LAST;

/*
Gold Result:
('A_Type',)
('B_Type',)
('C_Type',)
*/

-- Prediction Query
SELECT TYPE FROM film_market_estimation WHERE YEAR = 1995;

/*
Prediction Result:
('C_Type',)
('A_Type',)
('B_Type',)
*/