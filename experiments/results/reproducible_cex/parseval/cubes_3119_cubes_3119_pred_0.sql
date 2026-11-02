-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: film --
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483648, '5k5swwqcgs', 'fil_cdf870', '9n8', 1610062532);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483647, 'pgu7vfe4', 'fil_b37af3', 'Walter Hill', 1160656988);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (2, 'ia2yp', 'fil_cdf870', 'uzhsrwbbp6lu', 1019800248);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (3, 'dlttil', 'fil_cdf870', 'n', 462974032);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483646, 'posiie5unw6k', 'fil_b37af3', 'Walter Hill', 1151980946);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483643, 'a9', 'fil_83ba15', 'Walter Hill', 1620389964);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483642, '00t5c4ecigc', 'fil_cdf870', 'e376nium52', -443340271);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483641, 'uo4nrqrofqy', 'fil_de715f', '5s5b', 2107872094);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483640, '02eutliqa11r', 'fil_cdf870', 'ytoo3o9', -1666765085);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483639, '72klex14ji7z', 'fil_b37af3', 'fil_273fb2', -2081315180);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483638, '2dwyrq13pyu7', NULL, 'd99rljsl0', -2031361952);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (-2147483637, 'p5qi2rk', NULL, 'Walter Hill', -705985602);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "studio" FROM (SELECT * FROM "film" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "film" WHERE ("director" = 'Walter Hill')) AS RHS WHERE (LHS.studio = RHS.studio))) ORDER BY studio, "studio" NULLS LAST;

/*
Gold Result:
(None,)
('fil_cdf870',)
('fil_de715f',)
*/

-- Prediction Query
SELECT Studio FROM film EXCEPT SELECT Studio FROM film WHERE Director = 'Walter Hill';

/*
Prediction Result:
('fil_cdf870',)
('fil_de715f',)
*/