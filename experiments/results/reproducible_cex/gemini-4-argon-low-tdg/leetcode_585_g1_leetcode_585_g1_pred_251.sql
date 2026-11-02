-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (1, 10.0, 100.0, NULL, 10.0);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (2, 10.0, 200.0, 10.0, NULL);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (3, 10.0, 300.0, NULL, NULL);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (4, 10.0, 400.0, 50.0, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(400.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM (SELECT *, COUNT(*) OVER (PARTITION BY TIV_2015) AS CNT1, COUNT(*) OVER (PARTITION BY LAT, LON) AS CNT2 FROM INSURANCE) AS TBL WHERE CNT1 > 1 AND CNT2 = 1;

/*
Prediction Result:
(1000.0,)
*/