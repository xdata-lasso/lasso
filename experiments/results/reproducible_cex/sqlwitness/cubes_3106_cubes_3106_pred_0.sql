-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO film (film_id, title, studio, director, gross_in_dollar) VALUES (1994, NULL, NULL, NULL, 1995), (1995, NULL, 'default1', NULL, 1994), (1996, 'default1', 'default1', NULL, 0), (0, NULL, NULL, 'default1', NULL), (1, 'default2', NULL, NULL, NULL), (2, 'default2', 'default2', NULL, 1995), (3, 'default1', 'default2', 'default1', NULL), (4, NULL, 'default2', 'default1', 1), (5, 'default1', 'default2', 'default2', 1996), (6, NULL, 'default2', 'default1', 1994), (7, NULL, 'default2', 'default1', 1), (8, 'default1', 'default2', 'default2', 1995), (9, 'default1', 'default1', NULL, 1), (10, 'default2', NULL, 'default2', 1), (11, 'default1', 'default2', NULL, 1994), (12, 'default1', 'default2', NULL, 1995), (13, 'default2', NULL, NULL, NULL), (14, NULL, 'default1', NULL, 1994);
INSERT INTO film_market_estimation (estimation_id, market_id, film_id, low_estimate, high_estimate, type, year) VALUES (1994, NULL, 7, 1996.0, 1.0, NULL, 1994), (1996, NULL, 7, 1995.0, NULL, NULL, NULL), (1, NULL, NULL, 1995.0, NULL, 'default2', 1996), (1995, NULL, 1995, 1994.0, 1.0, NULL, 0), (0, NULL, NULL, 1.0, 1994.0, NULL, 1995), (2, NULL, 5, NULL, NULL, 'default2', 1996), (3, NULL, 7, 1996.0, 1995.0, 'default1', 1995), (4, NULL, 1995, 1996.0, 0.0, NULL, 1), (5, NULL, 13, 1996.0, NULL, NULL, NULL), (6, NULL, 11, 1995.0, 0.0, NULL, 1996), (7, NULL, 11, 1994.0, 0.0, NULL, 1994), (8, NULL, 1994, NULL, NULL, 'default2', 0), (9, NULL, 4, NULL, 0.0, NULL, 1995), (10, NULL, 5, 1995.0, 1.0, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM film_market_estimation WHERE (YEAR = 1995) ORDER BY TYPE, film_market_estimation.estimation_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT TYPE FROM film_market_estimation WHERE YEAR = 1995;

/*
Prediction Result:
(None,)
('default1',)
(None,)
*/