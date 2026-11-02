-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (1, 10.0, 100.126, 1.0, 1.0);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (2, 10.0, 200.0, 2.0, 2.0);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (3, NULL, 50.0, 3.0, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(300.13,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE WHERE (LAT, LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(PID) = 1) AND NOT TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(PID) = 1);

/*
Prediction Result:
(None,)
*/