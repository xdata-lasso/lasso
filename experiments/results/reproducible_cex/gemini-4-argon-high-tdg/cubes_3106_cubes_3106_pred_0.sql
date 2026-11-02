-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Sunrise', 'Fox', 'Murnau', 500000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'Metropolis', 'UFA', 'Lang', 1200000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (1, 'USA', 50);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (2, 'Germany', 20);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (1, 1, 1, 100.0, 200.0, 'Wide', 1995);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (2, 1, 2, 150.0, 300.0, 'Exclusive', 1995);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (3, 2, 1, 80.0, 120.0, 'Limited', 1995);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (4, 2, 2, 90.0, 110.0, 'Exclusive', 1995);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (5, 1, 1, 50.0, 75.0, 'Before1995', 1994);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (6, 2, 2, 200.0, 400.0, 'After1995', 1996);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT TYPE FROM film_market_estimation WHERE (YEAR = 1995) ORDER BY TYPE, film_market_estimation.estimation_id NULLS LAST;

/*
Gold Result:
('Exclusive',)
('Exclusive',)
('Limited',)
('Wide',)
*/

-- Prediction Query
SELECT TYPE FROM film_market_estimation WHERE YEAR = 1995;

/*
Prediction Result:
('Wide',)
('Exclusive',)
('Limited',)
('Exclusive',)
*/