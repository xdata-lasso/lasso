-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, 0, 2, 1, 2), (1, 3, 3, 3, NULL), (0, NULL, 0, 2, 1), (2, 2, 3, 0, 3), (4, 3, 3, 0, 0), (5, 2, 0, 2, 0), (6, 1, NULL, 3, NULL), (7, NULL, NULL, NULL, 1), (8, 1, 3, NULL, 1), (9, 0, 0, NULL, 3), (10, NULL, 0, 0, 0), (11, 0, 2, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(5.0,)
*/

-- Prediction Query
WITH CONDITIONS AS (SELECT *, COUNT(1) OVER (PARTITION BY LAT, LON) AS CITY_COUNT, COUNT(1) OVER (PARTITION BY TIV_2015) AS TIV_15_COUNT FROM INSURANCE) SELECT SUM(TIV_2016) AS TIV_2016 FROM CONDITIONS WHERE CITY_COUNT = 1 AND TIV_15_COUNT > 1;

/*
Prediction Result:
(7.0,)
*/