-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact equality boundary (4500000), off-by-one boundaries (4499999, 4500001),
-- DISTINCT elimination of duplicate studios, and ORDER BY sorting vs insertion order.
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'Film Z', 'Zeta Pictures', 'Dir A', 4500001);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (2, 'Film A1', 'Alpha Studios', 'Dir B', 4499999);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (3, 'Film A2', 'Alpha Studios', 'Dir C', 8000000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (4, 'Film B', 'Beta Films', 'Dir D', 4500000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT studio FROM (SELECT studio, title, AVG(gross_in_dollar) AS meangross_in_dollar FROM (SELECT * FROM film WHERE (gross_in_dollar <> 4500000)) GROUP BY studio, title) ORDER BY studio;

/*
Gold Result:
('Alpha Studios',)
('Zeta Pictures',)
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio HAVING AVG(Gross_in_dollar) >= 4500000;

/*
Prediction Result:
('Alpha Studios',)
('Beta Films',)
('Zeta Pictures',)
*/