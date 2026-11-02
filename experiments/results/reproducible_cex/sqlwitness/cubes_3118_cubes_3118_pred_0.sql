-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO film (film_id, title, studio, director, gross_in_dollar) VALUES (3, 'default2', 'default2', 'default1', 0), (1, NULL, NULL, 'default1', 3), (2, 'default1', NULL, NULL, NULL), (0, NULL, 'default1', NULL, NULL), (4, NULL, 'default2', NULL, 3), (5, 'default1', NULL, NULL, 1), (6, 'default1', 'default1', 'default2', NULL), (7, 'default2', NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT studio FROM (SELECT studio, COUNT(*) AS n FROM film GROUP BY studio) WHERE (n = 2) ORDER BY studio;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/