-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1046, 'Sports administrator', 'kind', 'discussion', 1047);
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1062, 'Designer, jewellery', 'save', 'knowledge', 1063);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1048, 'Kiribati', 1049);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1064, 'Guam', 1065);
INSERT INTO "market" ("market_id", "country", "number_cities") VALUES (1056, NULL, NULL);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1050, 1048, 1046, 1051.5, 1052.5, 'perform', 1053);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1058, 1056, 1046, 1059.5, 1060.5, 'song', 1061);
INSERT INTO "film_market_estimation" ("estimation_id", "market_id", "film_id", "low_estimate", "high_estimate", "type", "year") VALUES (1066, 1064, 1062, 1067.5, 1068.5, 'fall', 1069);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, TYPE FROM (SELECT LHS.film_id AS film_id, LHS.title AS title, LHS.studio AS studio, LHS.director AS director, LHS.gross_in_dollar AS gross_in_dollar, RHS.estimation_id AS estimation_id, RHS.low_estimate AS low_estimate, RHS.high_estimate AS high_estimate, RHS.type AS TYPE, RHS.market_id AS market_id, RHS.year AS YEAR FROM film AS LHS INNER JOIN film_market_estimation AS RHS ON (LHS.film_id = RHS.film_id)) ORDER BY title, TYPE NULLS LAST;

/*
Gold Result:
('Designer, jewellery', 'fall')
('Sports administrator', 'perform')
('Sports administrator', 'song')
*/

-- Prediction Query
SELECT T1.Title, T2.Type FROM film AS T1 JOIN film_market_estimation AS T2 ON T1.Film_ID = T2.Film_ID;

/*
Prediction Result:
('Sports administrator', 'perform')
('Sports administrator', 'song')
('Designer, jewellery', 'fall')
*/