-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'AAA', 'Warner Bros.', 'Walter Hill', 100000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'BBB', 'Paramount', 'Nicholas Meyer', 200000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'CCC', 'Universal', 'Steven Spielberg', 300000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (4, 'DDD', 'Columbia', 'Walter Hill', 400000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (5, 'EEE', 'Columbia', 'Walter Hill', 50000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (6, 'FFF', 'Fox', NULL, 500000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'USA', 50);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (2, 'UK', 20);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1, 1, 1, 50000.0, 150000.0, 'Domestic', 1980);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (2, 2, 1, 20000.0, 80000.0, 'Foreign', 1981);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (3, 1, 2, 100000.0, 250000.0, 'Domestic', 1982);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (4, 1, 3, 200000.0, 400000.0, 'Domestic', 1983);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "studio" FROM "film" WHERE ("director" <> 'Nicholas Meyer' AND "director" = 'Walter Hill') ORDER BY studio, film.film_id NULLS LAST;

/*
Gold Result:
('Columbia',)
('Columbia',)
('Warner Bros.',)
*/

-- Prediction Query
SELECT Studio FROM film WHERE Director = 'Nicholas Meyer' INTERSECT SELECT Studio FROM film WHERE Director = 'Walter Hill';

/*
Prediction Result:
*/