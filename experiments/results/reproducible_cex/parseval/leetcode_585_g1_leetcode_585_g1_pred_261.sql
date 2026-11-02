-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: insurance --
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1, 0.0, 0.0, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483647, 0.0, 582.588439, 680.190136, 487.053947);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483646, 0.0, 486.033807, 345.329712, 833.684115);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483645, 0.0, 261.897639, 97.952323, 171.746906);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483644, 0.0, 557.512061, 868.436572, 537.136345);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483643, 0.0, 38.937207, 249.706432, 99.523333);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483642, 0.0, 314.813297, 328.996339, 906.21648);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483641, 0.0, 483.665643, 818.685402, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483640, 0.0, 804.971537, 119.752245, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483639, 0.0, 134.487977, 941.961117, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483638, 1.0, 4.751658, 441.165949, 797.015047);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483637, 1.0, 241.913711, 759.708817, 882.963176);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483636, 1.0, 841.297061, 294.861575, 268.234631);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483635, 0.0, NULL, 349.034361, 30.774742);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483634, 0.0, NULL, 21.869121, 235.96352);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483633, 0.0, NULL, 185.86457, 737.440743);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483632, 0.0, 334.878198, NULL, 55.194297);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483631, 0.0, 303.05704, NULL, 125.12763);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483630, 0.0, 22.535764, NULL, 600.048938);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(3329.74,)
*/

-- Prediction Query
WITH UNIQUE_LOC AS (SELECT * FROM INSURANCE WHERE NOT (LAT, LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) > 1)), MULTIPLE_VALUE AS (SELECT * FROM INSURANCE WHERE TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) > 1)) SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM UNIQUE_LOC WHERE PID IN (SELECT PID FROM MULTIPLE_VALUE);

/*
Prediction Result:
(5413.34,)
*/