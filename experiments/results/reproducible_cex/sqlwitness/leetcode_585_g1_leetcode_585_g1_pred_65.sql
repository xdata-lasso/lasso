-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, 3, NULL, NULL, 0), (1, 2, NULL, 3, 3), (0, 0, 0, NULL, 1), (3, 1, 0, NULL, 0), (4, 0, 1, 0, 0), (5, 0, 2, NULL, 3), (6, 0, 1, NULL, 3), (7, 0, NULL, NULL, NULL), (8, NULL, 3, 2, 3), (9, 0, 3, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM (SELECT TIV_2016, COUNT(TIV_2015) OVER (PARTITION BY TIV_2015) AS DR1, COUNT(TIV_2015) OVER (PARTITION BY LAT, LON) AS DR2 FROM INSURANCE) AS T WHERE DR1 >= 2 AND DR2 = 1;

/*
Prediction Result:
(4.0,)
*/