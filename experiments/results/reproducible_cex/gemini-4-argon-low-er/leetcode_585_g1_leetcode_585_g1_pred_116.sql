-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (1, 100.0, 10.0, 1.0, 1.0);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (2, 100.0, 20.0, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(10.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(I.TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS I WHERE NOT I.PID IN (SELECT PID FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(TIV_2015) < 2) AND NOT (I.LAT, I.LON) IN (SELECT I2.LAT, I2.LON FROM INSURANCE AS I2 WHERE I.PID <> I2.PID);

/*
Prediction Result:
(None,)
*/