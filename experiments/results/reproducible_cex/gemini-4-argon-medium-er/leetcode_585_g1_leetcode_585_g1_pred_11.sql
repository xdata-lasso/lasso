-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (1, 10.0, 100.0, NULL, 20.0);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (2, 10.0, 200.0, 30.0, 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(200.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM (SELECT *, COUNT(*) OVER (PARTITION BY TIV_2015) AS CNT1, COUNT(*) OVER (PARTITION BY LAT, LON) AS CNT2 FROM INSURANCE) AS TBL WHERE TBL.CNT1 >= 2 AND TBL.CNT2 = 1;

/*
Prediction Result:
(300.0,)
*/