-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- General comprehensive dataset: tests unique vs duplicate TIV_2015, unique vs duplicate (LAT, LON),
-- independent LAT and LON uniqueness vs pair uniqueness, and decimal rounding to 2 places.
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES (1, 10.0, 5.123, 10.0, 10.0);
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES (2, 20.0, 20.0, 10.0, 20.0);
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES (3, 10.0, 30.0, 20.0, 20.0);
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES (4, 10.0, 40.123, 20.0, 20.0);
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES (5, 30.0, 50.0, 30.0, 30.0);
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES (6, 30.0, 60.0, 30.0, 30.0);
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES (7, 10.0, 15.124, 20.0, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE WHERE TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) > 1) AND (LAT, LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1);

/*
Gold Result:
(20.25,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM (SELECT *, COUNT(*) OVER (PARTITION BY TIV_2015) AS CNT1, COUNT(*) OVER (PARTITION BY LAT, LON) AS CNT2 FROM INSURANCE) AS T WHERE CNT1 > 1 AND CNT2 = 1;

/*
Prediction Result:
(20.247,)
*/