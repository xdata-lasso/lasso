-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (2, 0, 2, 3, 1), (0, 1, 2, 0, 0), (1, NULL, 2, 1, 2), (3, NULL, NULL, 3, 2), (4, 2, NULL, 0, 0), (5, 1, 2, 3, 3), (6, 0, 2, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(2.0,)
*/

-- Prediction Query
WITH CRITERIA AS (SELECT *, COUNT(*) OVER (PARTITION BY LAT, LON) AS CNT, COUNT(*) OVER (PARTITION BY TIV_2015) AS VAL FROM INSURANCE) SELECT SUM(TIV_2016) AS TIV_2016 FROM CRITERIA WHERE CNT = 1 AND VAL > 1;

/*
Prediction Result:
(4.0,)
*/