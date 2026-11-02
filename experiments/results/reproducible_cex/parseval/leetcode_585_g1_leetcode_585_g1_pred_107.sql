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

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483641, 0.0, 483.665643, 818.685402, 804.971537);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483640, 0.0, 119.752245, 134.487977, 941.961117);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483639, 0.0, 4.751658, 441.165949, 797.015047);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483638, 0.0, 241.913711, 759.708817, 882.963176);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483637, 0.0, 841.297061, 294.861575, 268.234631);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483636, 0.0, 349.034361, 30.774742, 21.869121);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483635, 0.0, 235.96352, 185.86457, 737.440743);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483634, 0.0, 334.878198, 55.194297, 303.05704);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483633, 0.0, 125.12763, 22.535764, 600.048938);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483632, 0.0, 240.969194, 267.815776, 192.379301);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483631, 0.0, 607.794538, 792.223623, 938.037625);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483630, 0.0, 921.185044, 235.059956, 619.836822);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483629, 1.0, 286.037632, 126.856521, 489.397796);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483628, 1.0, 933.422701, 345.718563, 510.466242);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483627, 0.0, 768.216462, NULL, 83.204633);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483626, 0.0, 5.585347, NULL, 871.191565);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483625, 0.0, 877.276439, 627.258639, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483624, 0.0, 801.414196, 890.762259, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483623, 0.0, NULL, 720.527846, 963.351729);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483622, 0.0, NULL, 827.854302, 983.124993);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(7967.58,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM (SELECT DISTINCT I1.* FROM INSURANCE AS I1 JOIN INSURANCE AS I2 ON I1.TIV_2015 = I2.TIV_2015 AND I1.PID <> I2.PID AND (I1.LAT <> I2.LAT OR I1.LON <> I2.LON) AND NOT (I1.LAT, I1.LON) IN (SELECT DISTINCT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) > 1)) AS A;

/*
Prediction Result:
(10420.07,)
*/