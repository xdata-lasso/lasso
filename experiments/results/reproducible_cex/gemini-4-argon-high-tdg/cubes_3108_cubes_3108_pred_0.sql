-- Schema DDL
CREATE TABLE "film" ("Film_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Studio" TEXT, "Director" TEXT, "Gross_in_dollar" INTEGER);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "Country" TEXT, "Number_cities" INTEGER);

CREATE TABLE "film_market_estimation" ("Estimation_ID" INTEGER PRIMARY KEY, "Market_ID" INTEGER, "Film_ID" INTEGER, "Low_Estimate" REAL, "High_Estimate" REAL, "Type" TEXT, "Year" INTEGER, FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"), FOREIGN KEY ("Film_ID") REFERENCES "film" ("Film_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (1, 'Film A', 'Studio 1', 'Director 1', 50000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (2, 'Film B', 'Studio 2', 'Director 2', 8000);
INSERT INTO film (Film_ID, Title, Studio, Director, Gross_in_dollar) VALUES (3, 'Film C', 'Studio 3', 'Director 3', 120000);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (10, 'USA', 100);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (20, 'UK', 30);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (30, 'France', 20);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (40, 'Germany', 15);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (50, 'Japan', 10);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (60, 'Canada', 40);
INSERT INTO market (Market_ID, Country, Number_cities) VALUES (70, 'Brazil', 500);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (101, 10, 1, 20000.0, 30000.0, 'Type A', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (102, 20, 1, 20000.0, 35000.0, 'Type A', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (103, 50, 1, 15000.0, 25000.0, 'Type B', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (104, 50, 1, 15000.0, 26000.0, 'Type B', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (105, 60, 1, 15000.0, 27000.0, 'Type B', 2021);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (106, 30, 2, 15000.0, 9000.0, 'Type C', 2022);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (107, 40, 2, 15000.0, 18000.0, 'Type C', 2022);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (108, 10, 2, 10000.0, 50000.0, 'Type D', 2020);
INSERT INTO film_market_estimation (Estimation_ID, Market_ID, Film_ID, Low_Estimate, High_Estimate, Type, Year) VALUES (109, 70, 1, 8000.0, 20000.0, 'Type D', 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meannumber_cities AS avg_t2_number_cities_ FROM (SELECT film_id, low_estimate, AVG(number_cities) AS meannumber_cities FROM (SELECT LHS.market_id AS market_id, LHS.country AS country, LHS.number_cities AS number_cities, RHS.estimation_id AS estimation_id, RHS.low_estimate AS low_estimate, RHS.high_estimate AS high_estimate, RHS.film_id AS film_id, RHS.type AS TYPE, RHS.year AS YEAR FROM market AS LHS INNER JOIN (SELECT * FROM film_market_estimation WHERE (low_estimate > 10000.0)) AS RHS ON (LHS.market_id = RHS.market_id)) GROUP BY film_id, low_estimate) ORDER BY avg_t2_number_cities_;

/*
Gold Result:
(17.5,)
(20.0,)
(65.0,)
*/

-- Prediction Query
SELECT AVG(T2.Number_cities) FROM film_market_estimation AS T1 JOIN market AS T2 ON T1.Market_ID = T2.Market_ID WHERE T1.Low_Estimate > 10000;

/*
Prediction Result:
(32.142857142857146,)
*/