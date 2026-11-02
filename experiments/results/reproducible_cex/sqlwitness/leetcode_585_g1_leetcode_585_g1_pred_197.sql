-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (3, 1, 3, NULL, NULL), (1, NULL, 0, 1, 1), (0, NULL, 1, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH CTE AS (SELECT *, COUNT(PID) OVER (PARTITION BY TIV_2015) AS CNT1, COUNT(PID) OVER (PARTITION BY LAT, LON) AS CNT2 FROM INSURANCE) SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM CTE WHERE CNT1 > 1 AND CNT2 = 1;

/*
Prediction Result:
(1.0,)
*/