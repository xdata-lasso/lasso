-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 0, NULL, 0, 1), (0, 3, 2, 0, 3), (2, NULL, NULL, 0, NULL), (3, 1, 3, 3, NULL), (4, NULL, 0, 1, 2), (5, 1, 0, 1, 0), (6, 0, 3, 0, 3), (7, 1, 0, NULL, 2), (8, NULL, 0, 3, NULL), (9, 0, 0, NULL, 2), (10, 1, NULL, 0, 2), (11, 3, 3, 1, NULL), (12, 3, 3, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TABLE1 AS (SELECT *, COUNT(TIV_2015) OVER (PARTITION BY TIV_2015) AS CNT_VALUE, COUNT(LAT) OVER (PARTITION BY LAT, LON) AS CNT_LOCATION FROM INSURANCE) SELECT SUM(TIV_2016) AS TIV_2016 FROM TABLE1 WHERE CNT_VALUE > 1 AND CNT_LOCATION = 1;

/*
Prediction Result:
(3.0,)
*/