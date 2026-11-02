-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: insurance --
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483648, 582.588439, 680.190136, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483647, 487.053947, 486.033807, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483646, 345.329712, 833.684115, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483645, 0.0, 261.897639, 97.952323, 171.746906);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483644, 0.0, 557.512061, 868.436572, 537.136345);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483643, 0.0, 38.937207, 249.706432, 99.523333);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483642, 0.0, NULL, 314.813297, 328.996339);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483641, 0.0, NULL, 906.21648, 483.665643);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483640, 818.685402, 804.971537, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483639, 119.752245, 134.487977, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483638, 941.961117, 4.751658, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483637, 0.0, 441.165949, 797.015047, 241.913711);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483636, 0.0, 759.708817, 882.963176, 841.297061);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483635, 0.0, 294.861575, 268.234631, 349.034361);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483634, 0.0, NULL, 30.774742, 21.869121);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483633, 0.0, NULL, 235.96352, 185.86457);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483632, 737.440743, 334.878198, NULL, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483631, 55.194297, 303.05704, NULL, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483630, 125.12763, 22.535764, NULL, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483629, 0.0, 600.048938, NULL, 240.969194);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483628, 0.0, 267.815776, NULL, 192.379301);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483627, 0.0, 607.794538, NULL, 792.223623);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483626, 0.0, NULL, NULL, 938.037625);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483625, 0.0, NULL, NULL, 921.185044);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483624, NULL, 235.059956, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483623, NULL, 619.836822, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483622, NULL, 286.037632, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483621, 1.0, 126.856521, 489.397796, 933.422701);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483620, 1.0, 345.718563, 510.466242, 768.216462);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483619, 1.0, 83.204633, 5.585347, 871.191565);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483618, 1.0, NULL, 877.276439, 627.258639);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483617, 1.0, NULL, 801.414196, 890.762259);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483616, 720.527846, 963.351729, 1.0, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483615, 827.854302, 983.124993, 1.0, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483614, 828.555322, 38.208914, 1.0, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483613, 0.0, 470.720385, 74.576035, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483612, 0.0, 725.945531, 42.488442, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483611, 0.0, 734.586266, 767.720387, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483610, 0.0, NULL, 44.682291, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483609, 0.0, NULL, 73.182847, NULL);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483608, 517.275698, NULL, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483607, 962.037451, NULL, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483606, 977.216501, NULL, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483605, 0.0, NULL, 769.021654, 805.746877);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483604, 0.0, NULL, 322.782838, 779.28645);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483603, 0.0, NULL, 566.030342, 452.706544);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483602, 0.0, NULL, 672.826911, 21.917736);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483601, 0.0, NULL, 325.900094, 478.908865);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483600, 203.577612, 710.219803, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483599, 979.158161, 250.982945, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483598, 274.680042, 680.514642, 1.0, 1.0);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483597, 0.0, 586.906897, 389.878901, 488.977171);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483596, 0.0, 285.519313, 718.756092, 17.844282);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483595, 0.0, 797.364011, 236.803246, 415.205312);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483594, 0.0, 442.009805, 576.439635, 325.080047);

INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (-2147483593, 0.0, 186.190286, 889.661694, 6.833035);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE WHERE TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) > 1) AND (LAT, LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1);

/*
Gold Result:
(5207.85,)
*/

-- Prediction Query
WITH LOCATION_COUNTS_1 AS (SELECT LAT, LON, COUNT(DISTINCT PID) AS LATLON_COUNT FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1), PIDS_WITH_UNIQUE_LOCATION AS (SELECT DISTINCT I.PID, L.LATLON_COUNT FROM INSURANCE AS I INNER JOIN LOCATION_COUNTS_1 AS L ON I.LAT = L.LAT AND I.LON = L.LON), PIDS_WITH_NONUNIQUE_TIV2015S AS (SELECT DISTINCT I.PID FROM INSURANCE AS I INNER JOIN INSURANCE AS I2 ON I.PID <> I2.PID AND I.TIV_2015 = I2.TIV_2015) SELECT SUM(TIV_2016) AS TIV_2016 FROM INSURANCE AS I INNER JOIN PIDS_WITH_UNIQUE_LOCATION AS U ON U.PID = I.PID INNER JOIN PIDS_WITH_NONUNIQUE_TIV2015S AS N ON N.PID = I.PID;

/*
Prediction Result:
(5207.853276999999,)
*/