-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Zootopia', 'Disney', 'Byron Howard', 1023784195);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'Avatar', 'Fox', 'James Cameron', 2787965087);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'Inception', 'Warner Bros', 'Christopher Nolan', 828322032);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (4, 'Matrix', 'Warner Bros', 'Wachowskis', 463517383);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'USA', 50);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (2, 'UK', 20);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (3, 'Japan', 15);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1, 2, 3, 100000.0, 200000.0, 'Theatrical', 2010);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (2, 1, 3, 300000.0, 500000.0, 'Theatrical', 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM film AS LHS WHERE NOT EXISTS(SELECT 1 FROM film_market_estimation AS RHS WHERE (LHS.film_id = RHS.film_id))) ORDER BY title;

/*
Gold Result:
('Avatar',)
('Matrix',)
('Zootopia',)
*/

-- Prediction Query
SELECT Title FROM film WHERE NOT Film_ID IN (SELECT Film_ID FROM film_market_estimation);

/*
Prediction Result:
('Zootopia',)
('Avatar',)
('Matrix',)
*/