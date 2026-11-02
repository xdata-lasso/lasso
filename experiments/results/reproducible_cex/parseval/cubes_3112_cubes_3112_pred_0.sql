-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: film --
INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (1, '5k5swwqcgs', 'fil_67cdda', 'Walter Hill', 247012447);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (2, '8c4pgu7vfe', 'fil_67cdda', 'Walter Hill', -1633151678);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (3, 'a2y', 'fil_67cdda', 'Walter Hill', 1115440883);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (4, 'hsrwbbp', 'luhvdltti', 'fil_1a2298', -1364429300);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (5, '5k5swwqcgs', '9n8', 'Nicholas Meyer', 1610062532);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (6, '5k5swwqcgs', '9n8', NULL, 1610062532);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (7, 'pgu7vfe4', 'hria2ypuzhs', NULL, 700293388);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (8, 'wbbp6luhvdlt', 'ilbnp', NULL, 1236688122);

INSERT INTO "film" ("film_id", "title", "studio", "director", "gross_in_dollar") VALUES (9, 'dpos', 'ie5', NULL, -1209887326);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "studio" FROM "film" WHERE ("director" <> 'Nicholas Meyer' AND "director" = 'Walter Hill') ORDER BY studio, film.film_id NULLS LAST;

/*
Gold Result:
('fil_67cdda',)
('fil_67cdda',)
('fil_67cdda',)
*/

-- Prediction Query
SELECT Studio FROM film WHERE Director = 'Nicholas Meyer' INTERSECT SELECT Studio FROM film WHERE Director = 'Walter Hill';

/*
Prediction Result:
*/