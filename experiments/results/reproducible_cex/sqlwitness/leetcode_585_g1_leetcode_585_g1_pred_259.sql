-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES (1, 3, NULL, 1, 3), (2, 1, NULL, 2, 3), (0, NULL, 0, NULL, 3), (3, NULL, 2, NULL, NULL), (4, 0, 1, 1, NULL), (5, 3, 0, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH TEMP1 AS (SELECT TIV_2016, COUNT(*) OVER (PARTITION BY TIV_2015) AS CT15, COUNT(*) OVER (PARTITION BY LAT, LON) AS CTLOC FROM INSURANCE) SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM TEMP1 WHERE CT15 > 1 AND CTLOC = 1;

/*
Prediction Result:
(2.0,)
*/