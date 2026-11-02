-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic count logic (1, 2, 3), ordering (inserted out of alphabetical order), and unnecessary INNER JOINs (some films have no market estimation).
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (1, 'Film 1', 'Universal', 'Dir A', 1000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (2, 'Film 2', 'Universal', 'Dir B', 2000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (3, 'Film 3', 'A24', 'Dir C', 3000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (4, 'Film 4', 'A24', 'Dir C', 4000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (5, 'Film 5', 'Paramount', 'Dir D', 5000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (6, 'Film 6', 'Warner Bros', 'Dir E', 6000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (7, 'Film 7', 'Warner Bros', 'Dir F', 7000);
INSERT INTO "film" ("Film_ID", "Title", "Studio", "Director", "Gross_in_dollar") VALUES (8, 'Film 8', 'Warner Bros', 'Dir G', 8000);
INSERT INTO "market" ("Market_ID", "Country", "Number_cities") VALUES (1, 'USA', 50);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (1, 1, 1, 100.0, 200.0, 'Type A', 2020);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (2, 1, 5, 100.0, 200.0, 'Type A', 2020);
INSERT INTO "film_market_estimation" ("Estimation_ID", "Market_ID", "Film_ID", "Low_Estimate", "High_Estimate", "Type", "Year") VALUES (3, 1, 5, 150.0, 250.0, 'Type B', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT studio FROM (SELECT studio, COUNT(*) AS n FROM film GROUP BY studio) WHERE (n = 2) ORDER BY studio;

/*
Gold Result:
('A24',)
('Universal',)
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio HAVING COUNT(*) >= 2;

/*
Prediction Result:
('A24',)
('Universal',)
('Warner Bros',)
*/