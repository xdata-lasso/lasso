-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, 1, 3, 3, 3), (1, 3, 2, NULL, NULL), (0, 3, 2, 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM (SELECT *, COUNT(PID) OVER (PARTITION BY TIV_2015) AS IV_OCCURENCE, COUNT(PID) OVER (PARTITION BY LAT, LON) AS LOCATION_OCCURENCE FROM INSURANCE) AS T WHERE IV_OCCURENCE > 1 AND LOCATION_OCCURENCE = 1;

/*
Prediction Result:
(4.0,)
*/