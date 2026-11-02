-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (1, 10.0, 10.0, NULL, NULL);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (2, 10.0, 20.0, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS I1 WHERE NOT (LAT, LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(LAT) > 1) AND TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE AS I2 WHERE I1.PID <> I2.PID);

/*
Prediction Result:
(30.0,)
*/