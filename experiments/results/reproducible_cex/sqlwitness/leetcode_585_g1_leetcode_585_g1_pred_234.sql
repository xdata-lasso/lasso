-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (0, NULL, 1, NULL, NULL), (1, 1, 0, NULL, 3), (2, NULL, 0, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH W AS (SELECT *, COUNT(*) OVER (PARTITION BY TIV_2015) AS SAME_TIV_2015, COUNT(*) OVER (PARTITION BY LAT, LON) AS UNIQUE_GEO FROM INSURANCE) SELECT SUM(TIV_2016) AS TIV_2016 FROM W WHERE SAME_TIV_2015 > 1 AND UNIQUE_GEO = 1;

/*
Prediction Result:
(1.0,)
*/