-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (0, 1, 1, 1, 0), (1, 3, 3, 2, NULL), (2, 3, 3, 3, 2), (3, 0, 2, 1, NULL), (4, 1, NULL, 1, 3), (5, 1, 0, 0, 1), (6, 3, NULL, 1, 0), (7, 3, 1, 3, NULL), (8, 2, 1, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM (SELECT TIV_2016, COUNT(PID) OVER (PARTITION BY TIV_2015) AS "2015_COUNT", COUNT(PID) OVER (PARTITION BY LAT, LON) AS LOCATION_COUNT FROM INSURANCE) AS TABLE1 WHERE "2015_COUNT" > 1 AND LOCATION_COUNT = 1;

/*
Prediction Result:
(7.0,)
*/