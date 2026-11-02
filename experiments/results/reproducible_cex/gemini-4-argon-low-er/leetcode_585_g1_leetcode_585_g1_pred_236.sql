-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (1, 100.0, 10.0, 1.0, 20.0);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (2, 100.0, 20.0, 1.02, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(30.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(I.TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS I WHERE I.TIV_2015 IN (SELECT BB.TIV_2015 FROM INSURANCE AS BB WHERE BB.PID <> I.PID) AND NOT I.LAT || I.LON IN (SELECT AA.LAT || AA.LON FROM INSURANCE AS AA WHERE AA.PID <> I.PID);

/*
Prediction Result:
(None,)
*/