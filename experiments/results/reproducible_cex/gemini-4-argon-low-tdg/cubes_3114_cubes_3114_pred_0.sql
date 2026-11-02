-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Zulu', 'Paramount', 'Cy Endfield', 100000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'Alpha', 'Sony', 'Albert Hughes', 200000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'Alpha', 'Universal', 'John Doe', 300000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (4, 'Beta', 'Warner', 'Jane Smith', 400000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (5, 'Gamma', 'Fox', 'Bob Brown', 500000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'USA', 50);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (2, 'UK', 20);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1, 1, 4, 1000.0, 2000.0, 'TypeA', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (2, 1, 5, 1500.0, 2500.0, 'TypeB', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (3, 2, 5, 3000.0, 4000.0, 'TypeA', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM film AS LHS WHERE NOT EXISTS(SELECT 1 FROM film_market_estimation AS RHS WHERE (LHS.film_id = RHS.film_id))) ORDER BY title;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT Title FROM film WHERE NOT Film_ID IN (SELECT Film_ID FROM film_market_estimation);

/*
Prediction Result:
('Zulu',)
('Alpha',)
('Alpha',)
*/