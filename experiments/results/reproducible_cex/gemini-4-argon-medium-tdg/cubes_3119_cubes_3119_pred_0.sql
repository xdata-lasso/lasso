-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in Studio and Director columns, and NULLS LAST ordering.
-- When Walter Hill has a NULL Studio, LHS.studio = RHS.studio evaluates to UNKNOWN, so NOT EXISTS is TRUE.
-- A mutant using NOT IN (SELECT Studio FROM film WHERE Director = 'Walter Hill') will return 0 rows for the entire query due to NULL in the NOT IN list.
-- Also tests whether NULL Studio in LHS is preserved and ordered last (NULLS LAST).
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'Indie Film 1', NULL, 'Walter Hill', 100000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (2, 'Indie Film 2', NULL, 'Quentin Tarantino', 500000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (3, 'Mystery Project', 'Sony', NULL, 300000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (4, 'Blockbuster', 'Disney', 'James Cameron', 1000000000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "studio" FROM (SELECT * FROM "film" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "film" WHERE ("director" = 'Walter Hill')) AS RHS WHERE (LHS.studio = RHS.studio))) ORDER BY studio, "studio" NULLS LAST;

/*
Gold Result:
(None,)
('Disney',)
('Sony',)
*/

-- Prediction Query
SELECT Studio FROM film EXCEPT SELECT Studio FROM film WHERE Director = 'Walter Hill';

/*
Prediction Result:
('Disney',)
('Sony',)
*/