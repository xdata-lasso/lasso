-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, 3, 1, NULL, 1), (0, 2, NULL, NULL, 3), (2, 3, 0, 3, 2), (1, NULL, 1, 1, 0), (4, 2, 0, NULL, 3), (5, 2, 0, 1, 0), (6, 3, 1, 1, 1), (7, 2, 2, NULL, 0), (8, 3, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
WITH COMPLETE AS (SELECT *, COUNT(PID) OVER (PARTITION BY TIV_2015) AS CRITERIA1, COUNT(PID) OVER (PARTITION BY LAT, LON) AS CRITERIA2 FROM INSURANCE) SELECT SUM(TIV_2016) AS TIV_2016 FROM COMPLETE WHERE CRITERIA1 > 1 AND CRITERIA2 = 1;

/*
Prediction Result:
(3.0,)
*/