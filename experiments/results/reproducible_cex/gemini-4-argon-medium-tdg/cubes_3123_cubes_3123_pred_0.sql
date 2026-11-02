-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'B_Movie', 'Studio1', 'Dir1', 100);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (2, 'A_Movie', 'Studio2', 'Dir2', 200);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (3, 'Unmatched_Movie', 'Studio3', 'Dir3', 300);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'USA', 50);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (1, 1, 1, 10.0, 20.0, 'Type_Z', 2020);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (2, 1, 1, 15.0, 25.0, 'Type_A', 2021);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (3, 1, 2, 30.0, 40.0, 'Type_M', 2022);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (4, 1, NULL, 5.0, 10.0, 'Orphan_Type', 2023);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, TYPE FROM (SELECT LHS.film_id AS film_id, LHS.title AS title, LHS.studio AS studio, LHS.director AS director, LHS.gross_in_dollar AS gross_in_dollar, RHS.estimation_id AS estimation_id, RHS.low_estimate AS low_estimate, RHS.high_estimate AS high_estimate, RHS.type AS TYPE, RHS.market_id AS market_id, RHS.year AS YEAR FROM film AS LHS INNER JOIN film_market_estimation AS RHS ON (LHS.film_id = RHS.film_id)) ORDER BY title, TYPE NULLS LAST;

/*
Gold Result:
('A_Movie', 'Type_M')
('B_Movie', 'Type_A')
('B_Movie', 'Type_Z')
*/

-- Prediction Query
SELECT T1.Title, T2.Type FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID = T2.Film_ID;

/*
Prediction Result:
('B_Movie', 'Type_Z')
('B_Movie', 'Type_A')
('A_Movie', 'Type_M')
*/