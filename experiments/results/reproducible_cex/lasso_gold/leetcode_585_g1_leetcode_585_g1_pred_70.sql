-- Schema DDL
CREATE TABLE "insurance" ("PID" INTEGER PRIMARY KEY, "TIV_2015" REAL, "TIV_2016" REAL, "LAT" REAL, "LON" REAL, CHECK ("tiv_2015" >= 0), CHECK ("tiv_2016" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1124, 1126.5, 39.766, 1127.5, 1129.5);
INSERT INTO "insurance" ("pid", "tiv_2015", "tiv_2016", "lat", "lon") VALUES (1125, 1126.5, 39.766, 1136.5, 1140.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016 FROM Insurance WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND (lat, lon) IN (SELECT lat, lon FROM Insurance WHERE NOT lat IS NULL AND NOT lon IS NULL GROUP BY lat, lon HAVING COUNT(*) = 1);

/*
Gold Result:
(79.53,)
*/

-- Prediction Query
WITH T1 AS (SELECT PID, TIV_2016, COUNT(*) OVER (PARTITION BY TIV_2015) AS C FROM INSURANCE) SELECT SUM(TIV_2016) AS TIV_2016 FROM T1 WHERE C > 1 AND NOT PID IN (SELECT I2.PID FROM INSURANCE AS I1 INNER JOIN INSURANCE AS I2 ON TRUE WHERE (I1.LAT = I2.LAT) AND (I1.LON = I2.LON) AND (I1.PID <> I2.PID));

/*
Prediction Result:
(79.532,)
*/