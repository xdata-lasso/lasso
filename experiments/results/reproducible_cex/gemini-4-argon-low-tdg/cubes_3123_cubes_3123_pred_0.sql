-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'B_Movie', 'StudioX', 'DirectorX', 100000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'A_Movie', 'StudioY', 'DirectorY', 200000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'C_Movie', 'StudioZ', 'DirectorZ', 300000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (4, 'Unmatched_Movie', 'StudioW', 'DirectorW', 400000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (10, 'USA', 50);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (100, 10, 1, 1000.0, 2000.0, 'Type_Z', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (101, 10, 1, 1500.0, 2500.0, 'Type_A', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (102, 10, 1, 1800.0, 2800.0, NULL, 2022);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (103, 10, 2, 5000.0, 6000.0, 'Type_B', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (104, 10, 2, 5000.0, 6000.0, 'Type_B', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (105, NULL, 3, 3000.0, 4000.0, 'Type_C', 2023);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (106, 10, NULL, 7000.0, 8000.0, 'Orphan_Type', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, TYPE FROM (SELECT LHS.film_id AS film_id, LHS.title AS title, LHS.studio AS studio, LHS.director AS director, LHS.gross_in_dollar AS gross_in_dollar, RHS.estimation_id AS estimation_id, RHS.low_estimate AS low_estimate, RHS.high_estimate AS high_estimate, RHS.type AS TYPE, RHS.market_id AS market_id, RHS.year AS YEAR FROM film AS LHS INNER JOIN film_market_estimation AS RHS ON (LHS.film_id = RHS.film_id)) ORDER BY title, TYPE NULLS LAST;

/*
Gold Result:
('A_Movie', 'Type_B')
('A_Movie', 'Type_B')
('B_Movie', 'Type_A')
('B_Movie', 'Type_Z')
('B_Movie', None)
('C_Movie', 'Type_C')
*/

-- Prediction Query
SELECT T1.Title, T2.Type FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID = T2.Film_ID;

/*
Prediction Result:
('B_Movie', 'Type_Z')
('B_Movie', 'Type_A')
('B_Movie', None)
('A_Movie', 'Type_B')
('A_Movie', 'Type_B')
('C_Movie', 'Type_C')
*/