-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (11, 797, NULL, 13, 14);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (10, 797, 1, 15, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE WHERE TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) > 1) AND NOT (LAT, LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) > 1);

/*
Prediction Result:
(1.0,)
*/