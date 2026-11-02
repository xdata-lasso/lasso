-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: film --
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1, 'fil_817d1b', 'fil_3c9efb', 'fil_aa4c12', 1);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483647, 'fil_60adf6', 'fil_4a34da', 'fil_a7c580', 1);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483646, '5k5swwqcgs', 'q_2_118a52', '9n8', 1610062532);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483645, 'pgu7vfe4', 'q_2_118a52', 'hria2ypuzhs', 700293388);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (2, 'wbbp6luhvdlt', 'ilbnp', 'mdpos', -1576219117);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (3, '5u', 'w6kl', 'a9', 1620389964);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT studio FROM (SELECT * FROM (SELECT * FROM (SELECT film_id, title, studio, director, gross_in_dollar, COUNT(*) OVER () AS n FROM film) ORDER BY director DESC) LIMIT 1);

/*
Gold Result:
('ilbnp',)
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio ORDER BY COUNT(*) DESC, Studio NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_118a52',)
*/