-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: film --
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1, '5k5swwqcgs', '9n8', 'fil_65eb87', 1610062532);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483647, 'pgu7vfe4', 'hria2ypuzhs', 'fil_65eb87', 700293388);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (2, 'wbbp6luhvdlt', 'ilbnp', NULL, 1236688122);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM film ORDER BY director, film.film_id NULLS LAST;

/*
Gold Result:
(None,)
('fil_65eb87',)
('fil_65eb87',)
*/

-- Prediction Query
SELECT DISTINCT Director FROM film;

/*
Prediction Result:
('fil_65eb87',)
(None,)
*/