-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1158, 1160.5, 1162.5, 1164.5, 1166.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1159, 1165.5, 1169.5, 1173.5, 1177.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1168, 1170.5, 1171.5, 1173.5, 1175.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1169, 1170.5, 1178.5, 1182.5, 1186.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1177, 1179.5, 1181.5, 1183.5, 1185.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1178, 1184.5, 1188.5, 1192.5, 1196.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1295, 1297.5, 1299.5, NULL, 1303.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1296, 1302.5, 1306.5, NULL, 1314.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1305, 1307.5, 1308.5, NULL, 1312.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1306, 1307.5, 1315.5, NULL, 1323.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1314, 1316.5, 1318.5, NULL, 1322.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1315, 1321.5, 1325.5, NULL, 1333.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM INSURANCE WHERE TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(*) > 1) AND (LAT, LON) IN (SELECT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1);

/*
Gold Result:
(2350.0,)
*/

-- Prediction Query
SELECT ROUND(SUM(A.TIV_2016), 2) AS TIV_2016 FROM INSURANCE AS A WHERE A.TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE AS B WHERE A.PID <> B.PID) AND NOT A.LAT || A.LON IN (SELECT C.LAT || C.LON FROM INSURANCE AS C WHERE A.PID <> C.PID);

/*
Prediction Result:
(None,)
*/