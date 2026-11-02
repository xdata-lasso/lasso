-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1138, 1140.5, 1141.5, 1143.5, 1145.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1139, 1140.5, 1148.5, 1152.5, 1156.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1147, 1149.5, 1150.5, NULL, 1152.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1148, 1149.5, 1157.5, NULL, 1163.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(2290.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(A.TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS A WHERE A.TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE AS B WHERE A.PID <> B.PID) AND NOT A.LAT || A.LON IN (SELECT C.LAT || C.LON FROM INSURANCE AS C WHERE A.PID <> C.PID);

/*
Prediction Result:
(None,)
*/