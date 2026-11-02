-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (13, 0, 4187, 15, NULL);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (12, 0, 1, 17, 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS I WHERE TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) > 1) AND NOT (I.LAT, I.LON) IN (SELECT I1.LAT, I1.LON FROM INSURANCE AS I1 GROUP BY 1, 2 HAVING COUNT(*) > 1);

/*
Prediction Result:
(4188.0,)
*/