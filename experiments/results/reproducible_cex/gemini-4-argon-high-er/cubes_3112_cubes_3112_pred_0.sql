-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, '48 Hrs.', 'Paramount', 'Walter Hill', 1000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "studio" FROM "film" WHERE ("director" <> 'Nicholas Meyer' AND "director" = 'Walter Hill') ORDER BY studio, film.film_id NULLS LAST;

/*
Gold Result:
('Paramount',)
*/

-- Prediction Query
SELECT Studio FROM film WHERE Director = 'Nicholas Meyer' INTERSECT SELECT Studio FROM film WHERE Director = 'Walter Hill';

/*
Prediction Result:
*/