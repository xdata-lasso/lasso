-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1124, 1126.5, 39.766, 1127.5, 1129.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1125, 1126.5, 39.766, 1136.5, 1140.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(79.53,)
*/

-- Prediction Query
WITH TEMP AS (SELECT *, COUNT(*) OVER (PARTITION BY LAT, LON) AS CNT, COUNT(*) OVER (PARTITION BY TIV_2015) AS TIV FROM INSURANCE) SELECT SUM(TIV_2016) AS TIV_2016 FROM TEMP WHERE TIV > 1 AND CNT = 1;

/*
Prediction Result:
(79.532,)
*/