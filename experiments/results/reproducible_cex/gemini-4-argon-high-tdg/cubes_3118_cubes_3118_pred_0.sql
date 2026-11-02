-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'USA', 50);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Film U1', 'Universal', 'Dir A', 100000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'Film U2', 'Universal', 'Dir B', 200000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'Film A1', 'A24', 'Dir C', 150000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (4, 'Film A2', 'A24', 'Dir D', 250000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (5, 'Film D1', 'Disney', 'Dir E', 300000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (6, 'Film D2', 'Disney', 'Dir F', 400000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (7, 'Film I1', 'Indie', 'Dir G', 50000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (8, 'Film M1', 'Marvel', 'Dir H', 500000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (9, 'Film M2', 'Marvel', 'Dir I', 600000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (10, 'Film M3', 'Marvel', 'Dir J', 700000);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1, 1, 7, 10000.0, 20000.0, 'Initial', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (2, 1, 7, 15000.0, 25000.0, 'Revised', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (3, 1, 1, 50000.0, 80000.0, 'Initial', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (4, 1, 1, 60000.0, 90000.0, 'Revised', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (5, 1, 2, 70000.0, 100000.0, 'Initial', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (6, 1, 2, 80000.0, 110000.0, 'Revised', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (7, 1, 5, 100000.0, 150000.0, 'Initial', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (8, 1, 6, 120000.0, 180000.0, 'Initial', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT studio FROM (SELECT studio, COUNT(*) AS n FROM film GROUP BY studio) WHERE (n = 2) ORDER BY studio;

/*
Gold Result:
('A24',)
('Disney',)
('Universal',)
*/

-- Prediction Query
SELECT Studio FROM film GROUP BY Studio HAVING COUNT(*) >= 2;

/*
Prediction Result:
('A24',)
('Disney',)
('Marvel',)
('Universal',)
*/