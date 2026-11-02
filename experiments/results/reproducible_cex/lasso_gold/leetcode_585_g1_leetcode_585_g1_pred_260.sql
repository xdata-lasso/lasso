-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1215, 1217.5, 1218.5, 1220.5, 1222.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1216, 1217.5, 1225.5, 1229.5, 1233.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1233, 1217.5, 1218.5, NULL, 1222.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(2444.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS I WHERE I.TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) >= 2) AND I.PID IN (SELECT PID FROM INSURANCE GROUP BY LAT || LON HAVING COUNT(*) < 2);

/*
Prediction Result:
(3662.5,)
*/