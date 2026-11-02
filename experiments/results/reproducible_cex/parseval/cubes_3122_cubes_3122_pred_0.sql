-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: film --
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1, 'rhs_fcc84f', 'rhs_c780f8', 'rhs_9de834', 1);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483647, 'rhs_9a6682', 'rhs_310ba7', 'rhs_bb5432', 1);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (3, 'rhs_fcc84f', 'rhs_c780f8', 'rhs_9de834', 1);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (2, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 13244799);

-- Inserting into table: market --
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1, '5k5swwqcgs', 247012447);

-- Inserting into table: film_market_estimation --
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1, 1, 1, 1.0, 1.0, 'lhs_57c599', 1995);

INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (-2147483647, 1, 1, 1.0, 1.0, 'lhs_b0f2fb', 1995);

INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (-2147483646, 1, 1, 1.0, 1.0, 'lhs_b0f2fb', 1995);

INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (-2147483645, 1, 1, 1.0, 1.0, 'lhs_b0f2fb', 1995);

INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (-2147483644, 1, 1, 1.0, 1.0, 'lhs_b0f2fb', 1995);

INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (-2147483643, 1, 1, 1.0, 1.0, 'lhs_b0f2fb', 1995);

INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (-2147483642, 1, 1, 1.0, 1.0, 'lhs_b0f2fb', 1995);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM (SELECT LHS.estimation_id AS estimation_id, LHS.low_estimate AS low_estimate, LHS.high_estimate AS high_estimate, LHS.film_id AS film_id, LHS.type AS TYPE, LHS.market_id AS market_id, LHS.year AS YEAR, RHS.title AS title, RHS.studio AS studio, RHS.director AS director, RHS.gross_in_dollar AS gross_in_dollar FROM film_market_estimation AS LHS INNER JOIN film AS RHS ON (LHS.film_id = RHS.film_id)) WHERE (YEAR = 1995) ORDER BY director;

/*
Gold Result:
('rhs_9de834',)
('rhs_9de834',)
('rhs_9de834',)
('rhs_9de834',)
('rhs_9de834',)
('rhs_9de834',)
('rhs_9de834',)
*/

-- Prediction Query
SELECT DISTINCT T1.Director FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID = T2.Film_ID WHERE T2.Year = 1995;

/*
Prediction Result:
('rhs_9de834',)
*/