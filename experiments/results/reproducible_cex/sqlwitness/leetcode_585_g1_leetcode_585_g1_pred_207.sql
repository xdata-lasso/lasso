-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, NULL, 2, 0, 0), (0, 1, 3, 2, 0), (2, 2, 3, NULL, 3), (3, 0, 2, 2, 2), (4, 2, 3, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
WITH INSURANCE_CTE AS (SELECT *, COUNT(PID) OVER (PARTITION BY TIV_2015) AS TIV_2015_CNT, COUNT(PID) OVER (PARTITION BY LAT, LON) AS PK_CNT FROM INSURANCE) SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE_CTE WHERE TIV_2015_CNT >= 2 AND PK_CNT = 1;

/*
Prediction Result:
(6.0,)
*/