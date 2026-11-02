-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (1, 10.0, 10.123, 1.0, 1.0);
INSERT INTO "insurance" ("PID", "TIV_2015", "TIV_2016", "LAT", "LON") VALUES (2, 10.0, 20.123, 2.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(30.25,)
*/

-- Prediction Query
SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE AS A WHERE (SELECT COUNT(*) FROM INSURANCE AS B WHERE A.LAT = B.LAT AND A.LON = B.LON) = 1 AND (SELECT COUNT(*) FROM INSURANCE AS C WHERE A.TIV_2015 = C.TIV_2015) > 1;

/*
Prediction Result:
(30.246000000000002,)
*/