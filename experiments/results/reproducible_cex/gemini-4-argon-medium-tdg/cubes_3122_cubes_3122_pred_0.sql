-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Year boundary conditions (1994, 1995, 1996, NULL), ORDER BY director (insert in reverse alphabetical order), and projected column mutations (Title, Studio, Type)
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'Title_Z', 'Studio_Z', 'Zack', 100000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (2, 'Title_A', 'Studio_A', 'Alice', 200000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (3, 'Title_B', 'Studio_B', 'Bob', 1995);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (4, 'Title_C', 'Studio_C', 'Charlie', 400000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (5, 'Title_D', 'Studio_D', 'David', 500000);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'USA', 1995);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (1, 1, 1, 10.5, 20.5, 'Type_Z', 1995);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (2, 1, 2, 15.0, 25.0, 'Type_A', 1995);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (3, 1, 3, 1995.0, 1995.0, 'Type_B', 1994);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (4, 1, 4, 30.0, 40.0, 'Type_C', 1996);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (5, 1, 5, 50.0, 60.0, 'Type_D', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM (SELECT LHS.estimation_id AS estimation_id, LHS.low_estimate AS low_estimate, LHS.high_estimate AS high_estimate, LHS.film_id AS film_id, LHS.type AS TYPE, LHS.market_id AS market_id, LHS.year AS YEAR, RHS.title AS title, RHS.studio AS studio, RHS.director AS director, RHS.gross_in_dollar AS gross_in_dollar FROM film_market_estimation AS LHS INNER JOIN film AS RHS ON (LHS.film_id = RHS.film_id)) WHERE (YEAR = 1995) ORDER BY director;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT T1.Director FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID = T2.Film_ID WHERE T2.Year = 1995;

/*
Prediction Result:
('Zack',)
('Alice',)
*/