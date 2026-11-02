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
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1324, 1297.5, 1326.5, 1328.5, 1330.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1325, 1297.5, 1333.5, 1337.5, 1341.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1332, 1297.5, 1334.5, 1336.5, 1338.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1333, 1297.5, 1341.5, 1345.5, 1349.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1340, 1297.5, 1342.5, 1344.5, 1346.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1341, 1297.5, 1349.5, 1353.5, 1357.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1348, 1160.5, 1162.5, NULL, 1166.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(11540.5,)
*/

-- Prediction Query
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016 FROM (SELECT DISTINCT I1.* FROM INSURANCE AS I1 JOIN INSURANCE AS I2 ON I1.TIV_2015 = I2.TIV_2015 AND I1.PID <> I2.PID AND (I1.LAT <> I2.LAT OR I1.LON <> I2.LON) AND (I1.LAT, I1.LON) IN (SELECT DISTINCT LAT, LON FROM INSURANCE GROUP BY LAT, LON HAVING COUNT(*) = 1)) AS A;

/*
Prediction Result:
(10378.0,)
*/